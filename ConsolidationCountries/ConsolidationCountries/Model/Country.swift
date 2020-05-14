//
//  Countries.swift
//  ConsolidationCountries
//
//  Created by Daniel Gx on 14/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation

struct Country: Decodable {
    let name: String?
    let capital: String?
    let countryCode: String?
    let demonym: String?
    let population: Int
    let region: String
    //let languages: [Language]

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case capital = "capital"
        case countryCode = "alpha2Code"
        case demonym = "demonym"
        case population = "population"
        case region = "region"
    }
}

struct Language: Codable {
    let iso6391: String?
    let iso6392: String
    let name: String
    let nativeName: String
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name
        case nativeName
    }
}
