//
//  MainViewModelTests.swift
//  WeatherForecastAppTests
//
//  Created by Lawrence on 10/30/23.
//

import XCTest
@testable import WeatherForecastApp

struct mockWebServiceRealtime: APIImplement {
    func fetchData<T>(request: WeatherForecastApp.Requestable, modelType: T.Type) async throws -> T where T : Decodable {
        let location = Location(lat: 100, lon: 100, name: "Some Where", type: nil)
        let realtimeData = RealtimeData(time: "2023-10-30T15:01:00Z", values: Constants.mockRealtimeValues)
        return Realtime(data: realtimeData, location: location) as! T
    }
}

struct mockWebServiceForecast: APIImplement {
    func fetchData<T>(request: WeatherForecastApp.Requestable, modelType: T.Type) async throws -> T where T : Decodable {
        let location = Location(lat: 100, lon: 100, name: "Some Where", type: nil)
        return Forecast(timelines: Timelines(daily: Constants.mockForecastTimelines),
                        location: location) as! T
    }
}

final class MainViewModelTests: XCTestCase {
    let viewModelRealtime = MainViewModel(webService: mockWebServiceRealtime())
    let viewModelForecast = MainViewModel(webService: mockWebServiceForecast())

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSearchForRealtime() throws {
        Task {
            await viewModelRealtime.searchForRealtime(location: "location")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let expectTime = "2023-10-30T15:01:00Z"
                let actualTime = self.viewModelRealtime.realTime!.data.time
                XCTAssertEqual(expectTime, actualTime)
            }
        }
    }
    
    func testSearchForForecast() throws {
        Task {
            await viewModelForecast.searchForForecast(location: "location")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                let expectLocation = "Some Where"
                let actualLocation = self.viewModelForecast.forecast!.location.name
                XCTAssertEqual(expectLocation, actualLocation)
            }
        }
    }

}
