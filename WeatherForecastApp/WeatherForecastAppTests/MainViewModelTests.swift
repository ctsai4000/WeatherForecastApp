//
//  MainViewModelTests.swift
//  WeatherForecastAppTests
//
//  Created by Lawrence on 10/30/23.
//

import XCTest
@testable import WeatherForecastApp

struct mockWebService: APIImplement {
    func fetchData<T>(location: String, path: String, modelType: T.Type) async throws -> T where T : Decodable {
        let realtimeData = RealtimeData(time: "2023-10-30T15:01:00Z", values: Constants.mockRealtimeValues)
        let mockLocation = Location(lat: 100, lon: 100, name: "Some Where", type: nil)
        if location == "forecast" {
            return Forecast(timelines: Timelines(daily: Constants.mockForecastTimelines),
                            location: mockLocation) as! T
        } else if location == "realtime" {
            return Realtime(data: realtimeData, location: mockLocation) as! T
        } else {
            throw NetworkError.invalidUrl
        }
    }
}

final class MainViewModelTests: XCTestCase {
    let mainViewModel = MainViewModel(webService: mockWebService())
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchForRealtimeSuccess() async throws {
        await mainViewModel.searchForRealtime(location: "realtime")
        
        let expectTime = "2023-10-30T15:01:00Z"
        let actualTime = mainViewModel.realTime!.data.time
        XCTAssertEqual(expectTime, actualTime)
    }
    
    func testSearchForRealtimeFailure() async throws {
        await mainViewModel.searchForRealtime(location: "location")
        XCTAssertEqual(mainViewModel.viewState, ViewState.error(msg: NetworkError.invalidUrl.localizedDescription))
    }
    
    func testSearchForForecastSuccess() async throws {
        await mainViewModel.searchForForecast(location: "forecast")
        
        let expectLocation = "Some Where"
        let actualLocation = mainViewModel.forecast!.location.name
        XCTAssertEqual(expectLocation, actualLocation)
    }
    
    func testSearchForForecastFailure() async throws {
        await mainViewModel.searchForForecast(location: "location")
        XCTAssertEqual(mainViewModel.viewState, ViewState.error(msg: NetworkError.invalidUrl.localizedDescription))
    }
    
}
