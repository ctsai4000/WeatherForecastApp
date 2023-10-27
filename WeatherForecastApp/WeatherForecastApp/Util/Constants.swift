//
//  Constants.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/27/23.
//

import Foundation

struct Constants {
    static let headers = ["accept": "application/json"]
    static let baseWeatherUrl = "https://api.tomorrow.io/v4/weather"
    static let apiKey = URLQueryItem(name: "apikey", value: "3DUmqqWrL6tHJqBhJTwoMnlCCayyr7ie")
}
