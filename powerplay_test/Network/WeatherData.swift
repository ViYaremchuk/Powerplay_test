//
//  WeatherData.swift
//  powerplay_test
//
//  Created by Monty Banks on 12.02.2024.
//

import Foundation

struct WeatherData: Decodable {
    let temperature: Double
    let windSpeed: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temperature_2m"
        case windSpeed = "wind_speed_10m"
    }
}

struct WeatherResponse: Decodable {
    let current: WeatherData
}
