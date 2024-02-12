//
//  CityModel.swift
//  powerplay_test
//
//  Created by Monty Banks on 12.02.2024.
//

import Foundation

struct City: Identifiable, Decodable {
    var city: String
    var city_ascii: String
    var lat: String
    var lng: String
    var country: String
    var iso2: String
    var iso3: String
    var admin_name: String
    var capital: String
    var population: String
    var id: String
}
