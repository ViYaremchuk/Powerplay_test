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
        // Safely unwrap latitude and longitude values from UserDefaults
        guard let lat = UserDefaults.standard.string(forKey: "selectedCityLat"),
              let lng = UserDefaults.standard.string(forKey: "selectedCityLng") else {
            print("Latitude and longitude are required but were not found.")
            // Here, you might want to handle the case where lat/lng are not available.
            // For example, you could show an error message or use default values.
            return
        }

        weatherService.fetchWeather(latitude: lat, longitude: lng) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherData):
                    // Assuming you have a way to create a 'Weather' instance from 'WeatherData'
                    self?.weather = Weather(city: city, temperature: weatherData.temperature, windSpeed: weatherData.windSpeed)
                case .failure(let error):
                    print(error.localizedDescription)
                    // Handle the error, such as showing an alert or setting an error state
                }
            }
        }
    }

    
}

struct Weather: Identifiable {
    let id = UUID() // For Identifiable conformance, if needed
    var city: String
    var temperature: Double
    var windSpeed: Double
    // Add any other weather-related properties you need
}
