//
//  MainView.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/27/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel(webService: WebService())
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        .onAppear {
            viewModel.searchForForecast(location: "Yongkang")
            viewModel.searchForRealtime(location: "Atlanta")
        }
    }
}

#Preview {
    MainView()
}
