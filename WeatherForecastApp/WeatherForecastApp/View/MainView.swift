//
//  MainView.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/27/23.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel(webService: WebService())
    @StateObject var locationManager = LocationManager()
    @State var isAlertPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                ProgressView()
                    .frame(maxHeight: .infinity)
            case .restricted, .denied:
                Text("Location Permission Denied")
                    .onAppear {
                        isAlertPresented = true
                    }
            case .authorizedAlways, .authorizedWhenInUse, .authorized:
                switch viewModel.viewState {
                case .error:
                    ErrorView(locationManager: locationManager, mainViewModel: viewModel)
                case .loaded:
                    if let realTime = Binding($viewModel.realTime), let forecast = Binding($viewModel.forecast) {
                        DetailView(mainViewModel: viewModel, realtime: realTime, forecast: forecast)
                    }
                case .loading:
                    ProgressView()
                        .frame(maxHeight: .infinity)
                }
            case .none, .some(_):
                ProgressView()
                    .frame(maxHeight: .infinity)
            }
        }
        .alert(isPresented: $isAlertPresented) {
            Alert (title: Text("Current Location"),
                   message: Text("he App would like to access your current locaiotn to provide you the weather"),
                   primaryButton: .default(Text("Settings"), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }),
                   secondaryButton: .destructive(Text("Cancel")))
        }
        .onAppear {
            if let latitude = locationManager.manager.location?.coordinate.latitude.description, let longitude = locationManager.manager.location?.coordinate.longitude {
                viewModel.currentLocation = "\(latitude), \(longitude)"
                viewModel.searchForRealtime(location: viewModel.currentLocation)
                viewModel.searchForForecast(location: viewModel.currentLocation)
            }
        }
    }
}

#Preview {
    MainView()
}
