//
//  MainViewModel.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/27/23.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var forecast: Forecast?
    @Published var realTime: Realtime?
    @Published var viewState = ViewState.loading
    @Published var location = ""
    @Published var currentLocation = ""
    
    let webService: APIImplement
    init(webService: APIImplement) {
        self.webService = webService
    }
    @MainActor
    func searchForForecast(location: String) {
        let paramLocation = URLQueryItem(name: "location", value: location)
        let networkRequest = NetworkRequest(baseUrl: "\(Constants.baseWeatherUrl)", 
                                            path: "forecast",
                                            params: [paramLocation, Constants.apiKey],
                                            type: .GET,
                                            headers: Constants.headers)
        Task {
            do {
                let result = try await webService.fetchData(request: networkRequest, modelType: Forecast.self)
                self.forecast = result
                viewState = .loaded
                print("forecast: \(result)")
            } catch {
                print(error)
                viewState = .error
            }
        }
    }
    @MainActor
    func searchForRealtime(location: String) {
        let paramLocation = URLQueryItem(name: "location", value: location)
        let networkRequest = NetworkRequest(baseUrl: "\(Constants.baseWeatherUrl)", 
                                            path: "realtime",
                                            params: [paramLocation, Constants.apiKey],
                                            type: .GET,
                                            headers: Constants.headers)
        Task {
            do {
                let result = try await webService.fetchData(request: networkRequest, modelType: Realtime.self)
                self.realTime = result
                viewState = .loaded
                print("realtime: \(result)")
            } catch {
                print(error)
                viewState = .error
            }
        }
    }
}
