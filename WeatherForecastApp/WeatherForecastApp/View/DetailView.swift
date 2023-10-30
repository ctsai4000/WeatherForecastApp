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
    @State var query = ""
    var body: some View {
        ZStack {
            if Int(realtime.data.values.weatherCode) < 2000 {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.29, green: 0.71, blue: 0.95), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.18, green: 0.17, blue: 0.74), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: -0.03, y: 1),
                    endPoint: UnitPoint(x: 1, y: 0)
                )
                .ignoresSafeArea()
            } else {
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: Color(red: 0.07, green: 0.1, blue: 0.14), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.17, green: 0.19, blue: 0.26), location: 1.00),
                    ],
                    startPoint: UnitPoint(x: 0.5, y: 0),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
                .ignoresSafeArea()
            }
            
            VStack(spacing: 20) {
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.white.opacity(0.5))
                        .padding(.leading, 6)
                    TextField("",
                              text: $query,
                              prompt:
                                Text("Search for a city")
                        .foregroundColor(Color.white.opacity(0.5))
                    )
                    .foregroundColor(.white)
                    .onChange(of: query){ newquery in
                        if newquery.count > 3 {
                            mainViewModel.location = newquery
                            mainViewModel.searchForRealtime(location: newquery)
                            mainViewModel.searchForForecast(location: newquery)
                        } else {
                            mainViewModel.searchForRealtime(location: mainViewModel.currentLocation)
                            mainViewModel.searchForForecast(location: mainViewModel.currentLocation)
                        }
                    }
                }
                .frame(height: 40)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.greyBlack.opacity(0.2))
                }
                .font(.system(size: 19))
                .fontWeight(.regular)
                
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
                        } else {
                            Text("N/A")
                            Text("N/A")
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
                        .padding(.horizontal, 15)
                    List {
                        ForEach(Array(forecast.timelines.daily.dropFirst(1)), id: \.self) { item in
                            WeatherRow(forecastDaily: item)
                                .frame(maxWidth: .infinity)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
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

#Preview {
    DetailView(mainViewModel: MainViewModel(webService: WebService()), realtime: .constant(Constants.mockRealtime), forecast: .constant(Constants.mockForecast))
}

extension String {
    func titlecased() -> String {
        return self.replacingOccurrences(of: "([A-Z])", with: " $1", options: .regularExpression, range: self.range(of: self))
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .capitalized
    }
}
