//
//  DetailCountryView.swift
//  ConsolidationCountries
//
//  Created by Daniel Gx on 14/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class DetailCountryView: UIViewController {
    
    // MARK: - Properties
    
    var country: Country?
    var selectedCountryImage: UIImage?

    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var countryDemonym: UILabel!
    @IBOutlet weak var countryPopulation: UILabel!
    @IBOutlet weak var countryLanguageFirst: UILabel!
    @IBOutlet weak var countryLanguageSecond: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryImage.image = selectedCountryImage
        countryName.text = "Name: " + (country?.name ?? "Unknown")
        countryCapital.text = "Capital: " + (country?.capital ?? "Unknown")
        countryDemonym.text = "Demonym: " + (country?.demonym ?? "Unknown")
        countryPopulation.text = "Population: \(country?.population ?? 0) habits"
    }
}
