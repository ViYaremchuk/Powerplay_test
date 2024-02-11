//
//  CitySearchView.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import Foundation
import SwiftUI

struct CitySearchView: View {
    @ObservedObject var viewModel = CitySearchViewModel()
    var coordinator: AppCoordinator

    var body: some View {
        NavigationView {
            VStack {
                if !viewModel.filteredCities.isEmpty {
                    List(viewModel.filteredCities, id: \.self) { city in
                        Button(city) {
                            coordinator.showWeatherView(for: city)
                        }
                    }
                } else {
                    Text("No results").padding()
                }
            }
            .navigationTitle("Select a City")
            .navigationBarItems(leading: Button("Back") {
                coordinator.showWeatherView(for: UserDefaults.standard.string(forKey: "selectedCity") ?? "Kyiv")
            })
            .searchable(text: $viewModel.searchText)
        }
    }
}
