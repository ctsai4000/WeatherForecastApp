//
//  Realtime.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/30/23.
//

import Foundation

// MARK: - Realtime
struct Realtime: Decodable {
    let data: RealtimeData
    let location: Location
}

//MARK: - RealtimeData
struct RealtimeData: Decodable {
    let time: String
    let values: RealtimeValues
}

// MARK: - RealtimeValues
struct RealtimeValues: Decodable {
    let cloudCeiling, cloudCover: Double?
    let dewPoint: Double
    let freezingRainIntensity: Double
    let humidity: Double
    let precipitationProbability: Double
    let pressureSurfaceLevel: Double
    let rainIntensity, sleetIntensity, snowIntensity: Double
    let temperature, temperatureApparent: Double
    let uvHealthConcern, uvIndex: Double
    let visibility: Double
    let weatherCode: Double
    let windDirection, windGust, windSpeed: Double
}


