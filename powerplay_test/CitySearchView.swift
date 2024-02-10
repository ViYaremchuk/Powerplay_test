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
    var body: some View {
        List {
            ForEach(viewModel.cities, id: \.self) { city in
                Text(city)
                    .onTapGesture {
                        viewModel.selectCity(city)
                        // Assuming a way to navigate back to WeatherView is implemented
                    }
            }
        }
        .searchable(text: $viewModel.searchText)
        .navigationTitle("Select a City")
    }
}
