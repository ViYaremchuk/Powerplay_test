//
//  WeatherView.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack {
            if let weather = viewModel.currentWeather {
                Text("City: \(weather.city)")
                Text("Temperature: \(weather.temperature, specifier: "%.1f")°C")
                Text("Condition: \(weather.condition)")
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            viewModel.loadLastSelectedCity()
        }
    }
}
