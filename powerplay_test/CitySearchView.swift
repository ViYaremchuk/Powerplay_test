//
//  CitySearchView.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import Foundation
import SwiftUI

struct CitySearchView: View {
    var coordinator: AppCoordinator

    var body: some View {
        List {
            Button("Kyiv") { coordinator.showWeatherView(for: "Kyiv") }
            Button("New York") { coordinator.showWeatherView(for: "New York") }
            Button("Tokyo") { coordinator.showWeatherView(for: "Tokyo") }
        }
        .navigationTitle("Select a City")
    }
}
