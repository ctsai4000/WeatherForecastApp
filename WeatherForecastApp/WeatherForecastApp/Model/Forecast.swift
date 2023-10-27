//
//  Forecast.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/27/23.
//

import Foundation

// MARK: - Realtime
struct Realtime: Decodable {
    let data: RealtimData
    let location: Location
}

//MARK: - RealtimeData
struct RealtimData: Decodable {
    let time: String
    let values: RealtimeValues
}

// MARK: - Forecast
struct Forecast: Decodable {
    let timelines: Timelines
    let location: Location
}

// MARK: - Location
struct Location: Decodable {
    let lat, lon: Double
    let name, type: String
}

// MARK: - Timelines
struct Timelines: Decodable {
//    let minutely: [Minutely]
//    let hourly: [Hourly]
    let daily: [Daily]
}

// MARK: - Daily
struct Daily: Decodable {
    let time: String
    let values: DailyValues
}

//// MARK: - Hourly
//struct Hourly: Decodable {
//    let time: String
//    let values: [String: Double?]
//}
//
//// MARK: - Minutely
//struct Minutely: Decodable {
//    let time: String
//    let values: [String: Double]
//}

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

// MARK: - DailyValues
struct DailyValues: Decodable {
    let cloudBaseAvg, cloudBaseMax, cloudBaseMin, cloudCeilingAvg: Double
    let cloudCeilingMax, cloudCeilingMin, cloudCoverAvg, cloudCoverMax: Double
    let cloudCoverMin, dewPointAvg, dewPointMax, dewPointMin: Double
    let evapotranspirationAvg, evapotranspirationMax, evapotranspirationMin, evapotranspirationSum: Double
    let freezingRainIntensityAvg, freezingRainIntensityMax, freezingRainIntensityMin: Int
    let humidityAvg, humidityMax, humidityMin: Double
    let iceAccumulationAvg, iceAccumulationLweAvg, iceAccumulationLweMax, iceAccumulationLweMin: Int
    let iceAccumulationLweSum, iceAccumulationMax, iceAccumulationMin, iceAccumulationSum: Int
    let moonriseTime, moonsetTime: String?
    let precipitationProbabilityAvg: Double
    let precipitationProbabilityMax, precipitationProbabilityMin: Int
    let pressureSurfaceLevelAvg, pressureSurfaceLevelMax, pressureSurfaceLevelMin, rainAccumulationAvg: Double
    let rainAccumulationLweAvg, rainAccumulationLweMax: Double
    let rainAccumulationLweMin: Int
    let rainAccumulationMax: Double
    let rainAccumulationMin: Int
    let rainAccumulationSum, rainIntensityAvg, rainIntensityMax: Double
    let rainIntensityMin, sleetAccumulationAvg, sleetAccumulationLweAvg, sleetAccumulationLweMax: Int
    let sleetAccumulationLweMin, sleetAccumulationLweSum, sleetAccumulationMax, sleetAccumulationMin: Int
    let sleetIntensityAvg, sleetIntensityMax, sleetIntensityMin, snowAccumulationAvg: Int
    let snowAccumulationLweAvg, snowAccumulationLweMax, snowAccumulationLweMin, snowAccumulationLweSum: Int
    let snowAccumulationMax, snowAccumulationMin, snowAccumulationSum: Int
    let snowDepthAvg, snowDepthMax, snowDepthMin, snowDepthSum: Int?
    let snowIntensityAvg, snowIntensityMax, snowIntensityMin: Int
    let sunriseTime, sunsetTime: String?
    let temperatureApparentAvg, temperatureApparentMax, temperatureApparentMin, temperatureAvg: Double
    let temperatureMax, temperatureMin: Double
    let uvHealthConcernAvg, uvHealthConcernMax, uvHealthConcernMin, uvIndexAvg: Int?
    let uvIndexMax, uvIndexMin: Int?
    let visibilityAvg, visibilityMax, visibilityMin: Double
    let weatherCodeMax, weatherCodeMin: Int
    let windDirectionAvg, windGustAvg, windGustMax, windGustMin: Double
    let windSpeedAvg, windSpeedMax, windSpeedMin: Double
}
