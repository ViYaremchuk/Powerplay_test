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
    
    @State private var startAnimation: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [
                        .pink.opacity(0.3),
                        .purple.opacity(0.3)],
                    startPoint: startAnimation ? .topLeading : .bottomLeading,
                    endPoint: startAnimation ? .bottomTrailing : .topTrailing
                )
                .ignoresSafeArea()
                VStack {
                    if viewModel.isLoading {
                        ProgressView("Loading Cities...")
                            .progressViewStyle(CircularProgressViewStyle())
                    } else {
                        cityListView
                    }
                }
                .searchable(text: $viewModel.searchText, prompt: "Search Cities")
                .navigationTitle("Select a City")
                .disabled(viewModel.isLoading)
                .navigationBarItems(leading: backButton)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private var cityListView: some View {
        ZStack {
            
            
            List(viewModel.filteredCities) { city in
                Button(action: {
                    coordinator.showWeatherView(for: city.city, lat: city.lat, lng: city.lng)
                }) {
                    VStack(alignment: .leading) {
                        Text(city.city ).bold()
                        Text(city.country).font(.caption)
                    }
                }
            }
            .background(.clear)
        }
    }
    
    private var backButton: some View {
        Button(action: {coordinator.showWeatherView(for: UserDefaults.standard.string(forKey: "selectedCity") ?? "Kyiv", lat: UserDefaults.standard.string(forKey: "selectedCityLat") ?? "50.4547", lng: UserDefaults.standard.string(forKey: "selectedCityLng") ?? "30.5238")}, label: {
            Image(systemName: "chevron.backward")
                .tint(.black)
                .bold()
        })
    }
}
