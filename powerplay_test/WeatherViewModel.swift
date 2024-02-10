//
//  WeatherViewModel.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var currentWeather: Weather?
    
    func fetchWeather(for city: String) {
        // Simulate fetching weather data
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.currentWeather = Weather(city: city, temperature: 20.0, condition: "Sunny")
        }
    }
    
    func loadLastSelectedCity() {
        let city = UserDefaults.standard.string(forKey: "selectedCity") ?? "Kyiv"
        fetchWeather(for: city)
    }
}
