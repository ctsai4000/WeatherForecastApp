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
    var timelines: Timelines
    let location: Location
}

// MARK: - Location
struct Location: Decodable {
    let lat, lon: Double
    let name, type: String?
}

// MARK: - Timelines
struct Timelines: Decodable {
//    let minutely: [Minutely]
//    let hourly: [Hourly]
    var daily: [Daily]
}

// MARK: - Daily
struct Daily: Decodable, Hashable {
    static func == (lhs: Daily, rhs: Daily) -> Bool {
        lhs.time == rhs.time
    }
    
    let time: String
    let values: DailyValues
    
    func timeFormat() -> String {
        let now = Date.now
        let dateFormatter = ISO8601DateFormatter()
        guard let date = dateFormatter.date(from: self.time) else { return "" }
        var calender = Calendar.current
        calender.timeZone = TimeZone.current
        let result = calender.compare(date, to: now, toGranularity: .day)
        if result == .orderedSame {
            return "Today"
        } else {
            let weekday = date.formatted(Date.FormatStyle().weekday(.abbreviated))
            return "\(weekday)"
        }
    }
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

// MARK: - WeatherCode
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
struct DailyValues: Decodable, Hashable {
//    let cloudBaseAvg, cloudBaseMax, cloudBaseMin, cloudCeilingAvg: Double
//    let cloudCeilingMax, cloudCeilingMin, cloudCoverAvg, cloudCoverMax: Double
//    let cloudCoverMin, dewPointAvg, dewPointMax, dewPointMin: Double
//    let evapotranspirationAvg, evapotranspirationMax, evapotranspirationMin, evapotranspirationSum: Double
//    let freezingRainIntensityAvg, freezingRainIntensityMax, freezingRainIntensityMin: Int
//    let humidityAvg, humidityMax, humidityMin: Double
//    let iceAccumulationAvg, iceAccumulationLweAvg, iceAccumulationLweMax, iceAccumulationLweMin: Int
//    let iceAccumulationLweSum, iceAccumulationMax, iceAccumulationMin, iceAccumulationSum: Int
//    let moonriseTime, moonsetTime: String?
//    let precipitationProbabilityAvg: Double
//    let precipitationProbabilityMax, precipitationProbabilityMin: Int
//    let pressureSurfaceLevelAvg, pressureSurfaceLevelMax, pressureSurfaceLevelMin, rainAccumulationAvg: Double
//    let rainAccumulationLweAvg, rainAccumulationLweMax: Double
//    let rainAccumulationLweMin: Int
//    let rainAccumulationMax: Double
//    let rainAccumulationMin: Int
//    let rainAccumulationSum, rainIntensityAvg, rainIntensityMax: Double
//    let rainIntensityMin, sleetAccumulationAvg, sleetAccumulationLweAvg, sleetAccumulationLweMax: Int
//    let sleetAccumulationLweMin, sleetAccumulationLweSum, sleetAccumulationMax, sleetAccumulationMin: Int
//    let sleetIntensityAvg, sleetIntensityMax, sleetIntensityMin, snowAccumulationAvg: Int
//    let snowAccumulationLweAvg, snowAccumulationLweMax, snowAccumulationLweMin, snowAccumulationLweSum: Int
//    let snowAccumulationMax, snowAccumulationMin, snowAccumulationSum: Int
//    let snowDepthAvg, snowDepthMax, snowDepthMin, snowDepthSum: Int?
//    let snowIntensityAvg, snowIntensityMax, snowIntensityMin: Int
    let sunriseTime, sunsetTime: String?
    let temperatureApparentAvg, temperatureApparentMax, temperatureApparentMin, temperatureAvg: Double
    let temperatureMax, temperatureMin: Double
//    let uvHealthConcernAvg, uvHealthConcernMax, uvHealthConcernMin, uvIndexAvg: Int?
//    let uvIndexMax, uvIndexMin: Int?
//    let visibilityAvg, visibilityMax, visibilityMin: Double
    let weatherCodeMax: Int
//    let windDirectionAvg, windGustAvg, windGustMax, windGustMin: Double
//    let windSpeedAvg, windSpeedMax, windSpeedMin: Double
}
