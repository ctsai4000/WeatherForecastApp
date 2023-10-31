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
    func searchForForecast(location: String) async {
        do {
            let result = try await webService.fetchData(location: location, path: "forecast", modelType: Forecast.self)
            self.forecast = result
            viewState = .loaded
            print("forecast: \(result)")
        } catch {
            print(error)
            viewState = .error(msg: error.localizedDescription)
        }
        
    }
    @MainActor
    func searchForRealtime(location: String) async {
        do {
            let result = try await webService.fetchData(location: location, path: "realtime", modelType: Realtime.self)
            self.realTime = result
            viewState = .loaded
            print("realtime: \(result)")
        } catch {
            print(error)
            viewState = .error(msg: error.localizedDescription)
        }
    }
    
}
