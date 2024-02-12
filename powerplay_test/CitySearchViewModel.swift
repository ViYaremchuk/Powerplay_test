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
    private lazy var allCities: [City] = []
    private var cancellables: Set<AnyCancellable> = []

    init() {
        self.allCities = loadCities()
        
        // Observe searchText changes and perform search asynchronously
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main) // Adjust timing as needed
            .removeDuplicates()
            .sink { [weak self] searchText in
                self?.searchCities(searchText)
            }
            .store(in: &cancellables)
    }
    
    func loadCities() -> [City] {
        guard let url = Bundle.main.url(forResource: "cities_list", withExtension: "json") else {
            fatalError("Failed to locate cities_list.json in bundle.")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode([City].self, from: data)
        } catch {
            fatalError("Failed to decode cities_list.json from bundle: \(error)")
        }
    }

    private func searchCities(_ query: String) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            let filtered: [City]
            if query.isEmpty {
                filtered = []
            } else {
                filtered = self.allCities.filter { $0.city.localizedCaseInsensitiveContains(query) }
            }
            
            // Dispatch results to the main queue to update UI
            DispatchQueue.main.async {
                self.filteredCities = filtered
            }
        }
    }
}
