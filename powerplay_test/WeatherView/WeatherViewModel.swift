//
//  WeatherViewModel.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import Foundation
import Combine

class WeatherViewModel: ObservableObject {
    @Published var weather: Weather? = nil
    private var weatherService = WeatherService()
    
    func fetchWeather(for city: String) {
        guard let lat = UserDefaults.standard.string(forKey: "selectedCityLat"),
              let lng = UserDefaults.standard.string(forKey: "selectedCityLng") else {
            print("Latitude and longitude are required but were not found.")
            return
        }
        
        weatherService.fetchWeather(latitude: lat, longitude: lng) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    self?.weather = Weather(city: city, temperature: weatherData.temperature, windSpeed: weatherData.windSpeed)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}

struct Weather: Identifiable {
    let id = UUID()
    var city: String
    var temperature: Double
    var windSpeed: Double
}
