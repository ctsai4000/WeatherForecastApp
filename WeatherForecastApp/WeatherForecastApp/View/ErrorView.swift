//
//  ErrorView.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/30/23.
//

import SwiftUI

struct ErrorView: View {
    var body: some View {
        Text("Location Not Found")
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background {
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
    }
}

#Preview {
    ErrorView()
}
