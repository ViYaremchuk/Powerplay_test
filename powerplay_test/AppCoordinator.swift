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
    func showWeatherView(for city: String, lat: String?, lng: String?) // Updated to include optional lat and lng parameters
    func showCitySearchView()
}

class AppCoordinator: Coordinator, ObservableObject {
    @Published var selectedCity: String?
    @Published var selectedLat: String? // Optional in case not all city selections include lat/lng
    @Published var selectedLng: String? // Optional for the same reason
    @Published var isCitySearchViewPresented: Bool = false

    init() {
        selectedCity = UserDefaults.standard.string(forKey: "selectedCity")
    }

    func start() {
        if let city = selectedCity {
            // Assuming you might store and want to retrieve lat/lng in the future,
            // you would also retrieve and set them here if they're stored
            showWeatherView(for: city, lat: nil, lng: nil) // Placeholder nil for lat/lng, adjust as needed
        } else {
            showWeatherView(for: "Kyiv", lat: nil, lng: nil) // Default to Kyiv if no city selected
        }
    }

    func showWeatherView(for city: String, lat: String? = nil, lng: String? = nil) {
        self.selectedCity = city
        self.selectedLat = lat
        self.selectedLng = lng
        UserDefaults.standard.set(city, forKey: "selectedCity")
        // Optionally store lat/lng in UserDefaults if needed for your app's functionality
        isCitySearchViewPresented = false
    }

    func showCitySearchView() {
        isCitySearchViewPresented = true
    }
}
