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

    var body: some View {
        VStack {
            if let weather = viewModel.weather {
                Text("City: \(weather.city)")
                Text("Temperature: \(weather.temperature, specifier: "%.1f")°C")
                Text("Condition: \(weather.condition)")
            } else {
                Text("Fetching weather data...")
            }
            Button("Change City") {
                coordinator.showCitySearchView()
            }
        }
        .onAppear {
            viewModel.fetchWeather(for: city)
        }
    }
}
