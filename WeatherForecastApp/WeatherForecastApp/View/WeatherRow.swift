//
//  WeatherRow.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/30/23.
//

import SwiftUI

struct WeatherRow: View {
    @State var forecastDaily: Daily
    var body: some View {
        VStack {
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
            
            CustomDivider()
        }
    }
}

#Preview {
    WeatherRow(forecastDaily: Daily(time: "2023-01-25T21:40:00Z", values: Constants.mockDailyValues))
        .background {
            Color.greyBlack.opacity(0.5)
        }
        .foregroundColor(.white)
}

struct CustomDivider: View {
    var body: some View {
        Divider()
            .frame(height: 0.2)
            .overlay(.white)
            .opacity(0.5)
    }
}
