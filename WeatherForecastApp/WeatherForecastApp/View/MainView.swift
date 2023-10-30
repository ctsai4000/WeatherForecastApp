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
    @State var query = ""
    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.29, green: 0.71, blue: 0.95), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.18, green: 0.17, blue: 0.74), location: 1.00),
                ],
                startPoint: UnitPoint(x: -0.03, y: 1),
                endPoint: UnitPoint(x: 1, y: 0)
            )
            .ignoresSafeArea()
            
            VStack {
                
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
                            viewModel.location = newquery
                            viewModel.searchForRealtime(location: newquery)
                            viewModel.searchForForecast(location: newquery)
                        }
                    }
                }
                .frame(height: 40)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.greyBlack.opacity(0.2))
                }
                .padding(.horizontal, 16)
                .font(.system(size: 19))
                .fontWeight(.regular)
                switch locationManager.authorizationStatus {
                case .notDetermined:
                    ProgressView()
                        .frame(maxHeight: .infinity)
                case .restricted, .denied:
                    Text("Denied")
                        .onAppear {
                            isAlertPresented = true
                        }
                case .authorizedAlways, .authorizedWhenInUse, .authorized:
                    switch viewModel.viewState {
                    case .error:
                        Text("Not Found")
                            .foregroundColor(.white)
                            .frame(maxHeight: .infinity)
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
                    viewModel.location = "\(latitude), \(longitude)"
                    viewModel.searchForRealtime(location: viewModel.location)
                    viewModel.searchForForecast(location: viewModel.location)
                }
        }
        }
    }
}

#Preview {
    MainView()
}
