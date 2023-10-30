//
//  Weathercode.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/30/23.
//

import Foundation

enum WeatherCode: Int {
    case clear = 1000
    case mostClear = 1100
    case partlyCloudy = 1101
    case mostlyCloudy = 1102
    case cloudy = 1001
    case lightFog = 2100
    case fog = 2000
    case drizzle = 4000
    case lightRain = 4200
    case rain = 4001
    case heavyRain = 4201
    case flurries = 5001
    case lightSnow = 5100
    case snow = 5000
    case heavySnow = 5101
    case freezingDrizzle = 6000
    case lightFreezingDrizzle = 6200
    case freezingRain = 6001
    case heavyFreezingRain = 6201
    case thunderStorm = 8000
}
