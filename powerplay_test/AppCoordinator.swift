//
//  AppCoordinator.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import Foundation
import Combine

protocol Coordinator {
    func start()
    func showWeatherView(for city: String)
    func showCitySearchView()
}

class AppCoordinator: Coordinator, ObservableObject {
    @Published var selectedCity: String?
    @Published var isCitySearchViewPresented: Bool = false

    init() {
        selectedCity = UserDefaults.standard.string(forKey: "selectedCity")
    }

    func start() {
        if selectedCity == nil {
            showWeatherView(for: "Kyiv")
        } else {
            showWeatherView(for: selectedCity!)
        }
    }

    func showWeatherView(for city: String) {
        selectedCity = city
        UserDefaults.standard.set(city, forKey: "selectedCity")
        isCitySearchViewPresented = false
    }

    func showCitySearchView() {
        isCitySearchViewPresented = true
    }
}
