//
//  MainViewModel.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/27/23.
//

import Foundation

class MainViewModel: ObservableObject {
    
    let webService: APIImplement
    init(webService: APIImplement) {
        self.webService = webService
    }
    
    func searchForForecast(location: String) {
        let paramLocation = URLQueryItem(name: "location", value: location)
        let networkRequest = NetworkRequest(baseUrl: "\(Constants.baseWeatherUrl)", path: "forecast", params: [paramLocation, Constants.apiKey], type: .GET, headers: Constants.headers)
        
        Task {
            do {
                let result = try await webService.fetchData(request: networkRequest, modelType: Forecast.self)
                print("forecast: \(result)")
            } catch {
                print(error)
            }
        }
    }
    
    func searchForRealtime(location: String) {
        let paramLocation = URLQueryItem(name: "location", value: location)
        let networkRequest = NetworkRequest(baseUrl: "\(Constants.baseWeatherUrl)", path: "realtime", params: [paramLocation, Constants.apiKey], type: .GET, headers: Constants.headers)
        
        Task {
            do {
                let result = try await webService.fetchData(request: networkRequest, modelType: Realtime.self)
                print("realtime: \(result)")
            } catch {
                print(error)
            }
        }
    }
}
