//
//  ErrorView.swift
//  WeatherForecastApp
//
//  Created by Lawrence on 10/30/23.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var locationManager: LocationManager
    @ObservedObject var mainViewModel: MainViewModel
    @State var errorMassage: String
    @State var isFoundLocation: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(errorMassage)")
                    .font(.system(size: 30))
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                Spacer()
                    .frame(height: 100)
                NavigationLink {
                    MainView()
                } label: {
                    Text("Refersh")
                        .opacity(0)
                }
                .navigationDestination(isPresented: $isFoundLocation) {
                    MainView()
                }

                Button(action: {
                    locationManager.manager.requestWhenInUseAuthorization()
                    Task {
                        if let latitude = locationManager.manager.location?.coordinate.latitude.description, let longitude = locationManager.manager.location?.coordinate.longitude {
                            mainViewModel.currentLocation = "\(latitude), \(longitude)"
                            await mainViewModel.searchForRealtime(location: mainViewModel.currentLocation)
                            await mainViewModel.searchForForecast(location: mainViewModel.currentLocation)
                            isFoundLocation = true
                        }
                    }
                    
                }, label: {
                    HStack {
                        Image(systemName: "arrow.counterclockwise")
                        Text("Refresh")
                    }
                    .font(.system(size: 21))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .background {
                        RoundedRectangle(cornerRadius: 15)
                            .inset(by: 0.25)
                            .stroke(.white.opacity(0.25), lineWidth: 0.5)
                            .frame(width: 260, height: 70)
                    }
                })
                
            }
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
}

#Preview {
    ErrorView(locationManager: LocationManager(), 
              mainViewModel: MainViewModel(webService: WebService()),
              errorMassage: "Location Not Found")
}
