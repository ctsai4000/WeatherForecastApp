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
        VStack {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                ProgressView()
            case .restricted, .denied:
                Text("Denied")
                    .onAppear {
                        isAlertPresented = true
                    }
            case .authorizedAlways, .authorizedWhenInUse, .authorized:
                Text("lat: \(locationManager.manager.location?.coordinate.latitude.description ?? "Error loading")")
                Text("long: \(locationManager.manager.location?.coordinate.longitude.description ?? "Error loading")")
            case .none, .some(_):
                ProgressView()
            }
        }
//        .alert("Current Location", isPresented: $isAlertPresented) {
//            Button("Setting") {
//                if let url = URL(string: UIApplication.openSettingsURLString) {
//                    UIApplication.shared.open(url)
//                }
//            }
//        } message: {
//            Text("The App would like to access your current locaiotn to provide you the weather")
//        }
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
                let location = "\(latitude), \(longitude)"
                viewModel.searchForRealtime(location: location)
            }
        }
    }
}

#Preview {
    MainView()
}
