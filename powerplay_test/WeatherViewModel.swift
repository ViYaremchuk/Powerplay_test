//
//  WeatherViewModel.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: Weather?
    
    func fetchWeather(for city: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.weather = Weather(city: city, temperature: 21.0, condition: "Sunny")
        }
    }
}

struct Weather {
    var city: String
    var temperature: Double
    var condition: String
}

