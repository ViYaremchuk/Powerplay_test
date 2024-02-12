//
//  CitySearchViewModel.swift
//  powerplay_test
//
//  Created by Monty Banks on 10.02.2024.
//

import Foundation
import Combine

class CitySearchViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var filteredCities: [City] = []
    @Published var isLoading = true
    private var allCities: [City] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        loadCitiesAsync()
        
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                guard !(self?.isLoading ?? true) else { return }
                self?.searchCities(searchText)
            }
            .store(in: &cancellables)
    }
    
    func loadCitiesAsync() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let url = Bundle.main.url(forResource: "cities_list", withExtension: "json"),
                  let data = try? Data(contentsOf: url),
                  let cities = try? JSONDecoder().decode([City].self, from: data) else {
                fatalError("Failed to load or decode cities_list.json from bundle.")
            }
            
            DispatchQueue.main.async {
                self?.allCities = cities
                self?.isLoading = false
            }
        }
    }
    
    private func searchCities(_ query: String) {
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let filtered: [City] = query.isEmpty ? [] : self.allCities.filter { $0.city.localizedCaseInsensitiveContains(query) }
            
            DispatchQueue.main.async {
                self.filteredCities = filtered
            }
        }
    }
}
