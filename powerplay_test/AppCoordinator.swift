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
    @Published var selectedLat: String?
    @Published var selectedLng: String?
    @Published var isCitySearchViewPresented: Bool = false

    init() {
        selectedCity = UserDefaults.standard.string(forKey: "selectedCity") ?? "Kyiv"
        selectedLat = UserDefaults.standard.string(forKey: "selectedCityLat") ?? "50.4547"
        selectedLng = UserDefaults.standard.string(forKey: "selectedCityLng") ?? "30.5238"
        // Directly use Kyiv's lat and lng if no city is selected
        if selectedCity == "Kyiv" || selectedCity == nil {
            selectedLat = "50.4547"
            selectedLng = "30.5238"
        }
    }

    func start() {
        if let city = selectedCity {
            showWeatherView(for: city, lat: selectedLat, lng: selectedLng)
        } else {
            showWeatherView(for: "Kyiv", lat: "50.4547", lng: "30.5238")
        }
    }

    func showWeatherView(for city: String, lat: String? = nil, lng: String? = nil) {
        self.selectedCity = city
        self.selectedLat = lat
        self.selectedLng = lng
        UserDefaults.standard.set(city, forKey: "selectedCity")
        UserDefaults.standard.set(lat, forKey: "selectedCityLat")
        UserDefaults.standard.set(lng, forKey: "selectedCityLng")
        // Optionally store lat/lng in UserDefaults if needed for your app's functionality
        isCitySearchViewPresented = false
    }

    func showCitySearchView() {
        isCitySearchViewPresented = true
    }
}
