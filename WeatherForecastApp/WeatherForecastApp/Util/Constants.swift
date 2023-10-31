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
    static let apiKey = URLQueryItem(name: "apikey", value: "tK1IIIWvbBWW9ikCxeiRhPM17WzRNdAK")
    static let mockRealtimeValues = RealtimeValues(cloudCeiling: 0.28,
                                        cloudCover: 0.28,
                                        dewPoint: 13.13,
                                        freezingRainIntensity: 0,
                                        humidity: 87,
                                        precipitationProbability: 0,
                                        pressureSurfaceLevel: 1004.15,
                                        rainIntensity: 0,
                                        sleetIntensity: 0,
                                        snowIntensity: 0,
                                        temperature: 15.31,
                                        temperatureApparent: 15.31,
                                        uvHealthConcern: 0,
                                        uvIndex: 1,
                                        visibility: 15.68,
                                        weatherCode: 1001,
                                        windDirection: 222.31,
                                        windGust: 7.88,
                                        windSpeed: 3.63)
    static let mockLocation = Location(lat: 43.653480529785156,
                            lon: -79.3839340209961,
                            name: "Old Toronto, Toronto, Golden Horseshoe, Ontario, Canada",
                            type: "administrative")
    static let mockRealtime = Realtime(data: RealtimeData(time: "2023-10-27T15:01:00Z",
                                              values: mockRealtimeValues),
                            location: mockLocation)
    static let mockDailyValues = DailyValues(sunriseTime: "2023-01-25T21:40:00Z",
                                  sunsetTime: "2023-01-26T08:06:00Z",
                                  temperatureApparentAvg: 1.47,
                                  temperatureApparentMax: 7.63,
                                  temperatureApparentMin: -6.4,
                                  temperatureAvg: 2.55,
                                  temperatureMax: 7.63,
                                  temperatureMin: -5.19,
                                  weatherCodeMax: 5100)
    static let mockForecastTimelines = [Daily(time: "2023-01-25T21:00:00Z", values: mockDailyValues),
                             Daily(time: "2023-01-26T21:00:00Z", values: mockDailyValues)]
    static let mockForecast = Forecast(timelines: Timelines(daily: mockForecastTimelines), location: mockLocation)
}
