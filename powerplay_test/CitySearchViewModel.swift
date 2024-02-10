//
//  CitySearchViewModel.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import Foundation
import Combine

class CitySearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var cities: [String] = ["Kyiv", "New York", "Tokyo"] // Example cities
    
    func selectCity(_ city: String) {
        UserDefaults.standard.set(city, forKey: "selectedCity")
    }
}
