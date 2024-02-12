//
//  ContentView.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var coordinator = AppCoordinator()
    
    var body: some View {
        NavigationView {
            if let city = coordinator.selectedCity, !coordinator.isCitySearchViewPresented {
                WeatherView(coordinator: coordinator, city: city)
            } else {
                CitySearchView(coordinator: coordinator)
            }
        }
        .onAppear {
            coordinator.start()
        }
    }
}

