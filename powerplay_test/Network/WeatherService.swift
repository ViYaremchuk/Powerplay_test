//
//  WeatherService.swift
//  powerplay_test
//
//  Created by Monty Banks on 12.02.2024.
//

import Foundation

class WeatherService {
    func fetchWeather(latitude: String, longitude: String, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,wind_speed_10m"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            print(urlString)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -2, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            do {
                let weatherResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
                print("data: ", weatherResponse)
                completion(.success(weatherResponse.current))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
