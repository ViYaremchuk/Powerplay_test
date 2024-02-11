//
//  CitySearchViewModel.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import Foundation
import Combine

class CitySearchViewModel: ObservableObject {
    @Published var searchText = "" {
        didSet {
            searchCities()
        }
    }
    @Published var filteredCities: [String] = []
    private var allCities = ["Kyiv", "New York", "Tokyo", "London"] // Example city list

    init() {
        // Initial search or wait for user input based on requirements
    }

    func searchCities() {
        if searchText.isEmpty {
            filteredCities = []
        } else {
            filteredCities = allCities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}
