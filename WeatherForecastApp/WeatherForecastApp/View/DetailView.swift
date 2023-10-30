//
//  DetailView.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/28/23.
//

import SwiftUI



struct DetailView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @Binding var realtime: Realtime
    @Binding var forecast: Forecast
    var body: some View {
        ZStack {
            //            LinearGradient(
            //                stops: [
            //                    Gradient.Stop(color: Color(red: 0.07, green: 0.1, blue: 0.14), location: 0.00),
            //                    Gradient.Stop(color: Color(red: 0.17, green: 0.19, blue: 0.26), location: 1.00),
            //                ],
            //                startPoint: UnitPoint(x: 0.5, y: 0),
            //                endPoint: UnitPoint(x: 0.5, y: 1)
            //            )
//            LinearGradient(
//                stops: [
//                    Gradient.Stop(color: Color(red: 0.29, green: 0.71, blue: 0.95), location: 0.00),
//                    Gradient.Stop(color: Color(red: 0.18, green: 0.17, blue: 0.74), location: 1.00),
//                ],
//                startPoint: UnitPoint(x: -0.03, y: 1),
//                endPoint: UnitPoint(x: 1, y: 0)
//            )
//            .ignoresSafeArea()
            
            VStack {
                VStack(spacing: -2) {
                    HStack(spacing: 5) {
                        if let locationName = realtime.location.name {
                            Text("\(locationName.components(separatedBy: ", ")[0])")
                        } else {
                            Image(systemName: "location.fill")
                            Text(" Current Location")
                        }
                    }
                    .fontWeight(.regular)
                    .font(.system(size: 37))
                    Text("\(Int(realtime.data.values.temperatureApparent.rounded()))º")
                        .fontWeight(.thin)
                        .font(.system(size: 102))
                    if let weatherDes = WeatherCode(rawValue: Int(realtime.data.values.weatherCode.rounded())) {
                        Text("\(weatherDes)".titlecased())
                            .fontWeight(.regular)
                            .font(.system(size: 24))
                    }
                    
                    HStack(spacing: 5) {
                        if let temperatureMax = forecast.timelines.daily.first?.values.temperatureApparentMax, let temperatureMin = forecast.timelines.daily.first?.values.temperatureApparentMin {
                            Text("H: \(Int(temperatureMax.rounded()))º")
                            Text("L: \(Int(temperatureMin.rounded()))º")
                        }
                        
                    }
                    .fontWeight(.medium)
                    .font(.system(size: 21))
                }
                .frame(maxWidth: .infinity, alignment: .center)
                
                VStack {
                    HStack {
                        Image(systemName: "calendar")
                        Text("5-DAY FORECAST")
                    }
                    .fontWeight(.medium)
                    .font(.system(size: 15))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 15)
                    
                    CustomDivider()
                    List {
                        ForEach(Array(forecast.timelines.daily.dropFirst(1)), id: \.self) { item in
                            WeatherRow(forecastDaily: item)
                                .frame(maxWidth: .infinity)
                                .listRowBackground(Color.clear)
                        }
                    }
                    .refreshable {
                        mainViewModel.searchForForecast(location: mainViewModel.location)
                        mainViewModel.searchForRealtime(location: mainViewModel.location)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    .scrollIndicators(.hidden)
                }
                .padding(.vertical, 14)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color.greyBlack.opacity(0.2))
                    
                }
            }
            .padding(.horizontal, 20)
            .foregroundColor(.white)
        }
    }
}

let realtimeValues = RealtimeValues(cloudCeiling: 0.28,
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
let location = Location(lat: 43.653480529785156,
                        lon: -79.3839340209961,
                        name: "Old Toronto, Toronto, Golden Horseshoe, Ontario, Canada",
                        type: "administrative")
let realtime = Realtime(data: RealtimData(time: "2023-10-27T15:01:00Z",
                                          values: realtimeValues),
                        location: location)
let dailyValues = DailyValues(sunriseTime: "2023-01-25T21:40:00Z",
                              sunsetTime: "2023-01-26T08:06:00Z",
                              temperatureApparentAvg: 1.47,
                              temperatureApparentMax: 7.63,
                              temperatureApparentMin: -6.4,
                              temperatureAvg: 2.55,
                              temperatureMax: 7.63,
                              temperatureMin: -5.19,
                              weatherCodeMax: 5100)
let forecastTimelines = [Daily(time: "2023-01-25T21:00:00Z", values: dailyValues),
                         Daily(time: "2023-01-26T21:00:00Z", values: dailyValues)]
let forecast = Forecast(timelines: Timelines(daily: forecastTimelines), location: location)
#Preview {
    DetailView(mainViewModel: MainViewModel(webService: WebService()), realtime: .constant(realtime), forecast: .constant(forecast))
}

struct WeatherRow: View {
    @State var forecastDaily: Daily
    var body: some View {
        HStack(alignment: .center) {
            Text("\(forecastDaily.timeFormat())")
                .frame(maxWidth: 58, alignment: .leading)
            if let weatherIcon = WeatherCode(rawValue: forecastDaily.values.weatherCodeMax) {
                Image("\(weatherIcon)")
                    .frame(minWidth: 28, alignment: .center)
            }
            Text("\(Int(forecastDaily.values.temperatureApparentMin.rounded()))º")
                .foregroundColor(Color.white.opacity(0.3))
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 100, height: 4)
                .background(Color.black.opacity(0.15))
                .cornerRadius(44)
                .overlay {
                    Rectangle()
                        .foregroundColor(Color("TemperatureBarColor"))
                        .frame(width: 42, height: 4)
                        .cornerRadius(44)
                }
            Text("\(Int(forecastDaily.values.temperatureApparentMax.rounded()))º")
        }
        .frame(maxWidth: .infinity)
        .fontWeight(.medium)
        .font(.system(size: 18))
        .frame(height: 55)
    }
}

struct CustomDivider: View {
    var body: some View {
        Divider()
            .frame(height: 0.2)
            .overlay(.white)
            .opacity(0.5)
    }
}

extension String {
    func titlecased() -> String {
        return self.replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: self.range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}
