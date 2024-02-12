//
//  WeatherView.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    var coordinator: AppCoordinator
    var city: String
    @State private var startAnimation: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    .purple,
                    .blue],
                startPoint: startAnimation ? .topLeading : .bottomLeading,
                endPoint: startAnimation ? .bottomTrailing : .topTrailing
            )
            .ignoresSafeArea()
            VStack {
                if let weather = viewModel.weather {
                    Text("\(weather.city)").font(.largeTitle)
                    Text("\(weather.temperature, specifier: "%.0f")°").font(.system(size: 60))
                    Text("wind speed")
                    Text("\(weather.windSpeed, specifier: "%.1f") km/h").bold()
                } else {
                    Text("Fetching weather data...")
                }
                Spacer()
            }
            .padding(.top, 120)
            .onAppear {
                viewModel.fetchWeather(for: city)
                withAnimation(.linear(duration: 5.0).repeatForever()) {
                    startAnimation.toggle()
                }
            }
            VStack (alignment: .trailing, content: {
                HStack {
                    Spacer()
                    Button(action: {coordinator.showCitySearchView()}, label: {
                        Image(systemName: "magnifyingglass")
                            .tint(.black)
                            .bold()
                    })
                }
                .padding()
                Spacer()
            })
        }
    }
}

