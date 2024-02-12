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
                    List(viewModel.filteredCities) { city in
                        Button(action: {
                            coordinator.showWeatherView(for: city.city, lat: city.lat, lng: city.lng)
                        }) {
                            VStack(alignment: .leading) {
                                Text(city.city).bold()
                                Text(city.country).font(.caption)
                            }
                        }
                    }
                } else {
                    Text("Start typing to search for cities...")
                        .padding()
                }
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle("Select a City")
            .navigationBarItems(leading: Button("Back") {
                coordinator.showWeatherView(for: UserDefaults.standard.string(forKey: "selectedCity") ?? "Kyiv", lat: nil, lng: nil)
            })
        }
    }
}
