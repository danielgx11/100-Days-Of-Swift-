//
//  Countries.swift
//  ConsolidationCountries
//
//  Created by Daniel Gx on 14/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation

struct Language: Codable {
    var iso6391: String?
    var iso6392: String
    var name: String
    var nativeName: String
    
    enum CodingKeys: String, CodingKey {
        case name, nativeName
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
    }
}

struct Country: Codable {
    var name: String
    var capital: String
    var alpha2Code: String
    var alpha3Code: String
    var region: String
    var subregion: String
    var demonym: String
    var population: Int
    var latlng: [Double]
    var languages: [Language]
}

