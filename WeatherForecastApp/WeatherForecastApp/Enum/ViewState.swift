//
//  ViewState.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/30/23.
//

import Foundation

enum ViewState: Equatable {
    case loading
    case loaded
    case error(msg: String)
}
