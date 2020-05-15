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
    var indexPath = 0

    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryCapital: UILabel!
    @IBOutlet weak var countryDemonym: UILabel!
    @IBOutlet weak var countryPopulation: UILabel!
    @IBOutlet weak var countryLanguageFirst: UILabel!
    @IBOutlet weak var countryLanguageSecond: UILabel!
    @IBOutlet weak var countryLanguageName: UILabel!
    @IBOutlet weak var countryLanguageNativeName: UILabel!
    @IBOutlet weak var countryRegion: UILabel!
    @IBOutlet weak var countrySubRegion: UILabel!
    @IBOutlet weak var countryGeoCoordinates: UILabel!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
        setLabels()
    }
    
    // MARK: - Methods
    
    func customizeNavigationController() {
        title = country?.name
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func setLabels() {
        countryImage.image = selectedCountryImage
        countryName.text = "Name: " + (country?.name ?? "Unknown")
        countryCapital.text = "Capital: " + (country?.capital ?? "Unknown")
        countryDemonym.text = "Demonym: " + (country?.demonym ?? "Unknown")
        countryPopulation.text = "Population: \(country?.population ?? 0) habits"
        countryLanguageFirst.text = "Abreviation Language: \(country?.languages[indexPath].iso6391 ?? "Unkwnown")"
        countryLanguageSecond.text = "Abreviation Language: \(country?.languages[indexPath].iso6392 ?? "Unkwnown")"
        guard let countryLanguage = country?.languages.first?.name, let countryOfficialLanguage = country?.languages.first?.nativeName else {
            countryLanguageName.text = "Name: Unknown"
            countryLanguageNativeName.text = "Language Official Name: Unknown"
            return
        }
        countryLanguageName.text = "Name: \(countryLanguage)"
        countryLanguageNativeName.text = "Language Official Name: \(countryOfficialLanguage)"
        countryRegion.text = "Region: \(country?.region ?? "Unknown")"
        countrySubRegion.text = "Sub-Region: \( country?.subregion ?? "Unknown")"
        countryGeoCoordinates.text = "Latitude: \(country?.latlng[0] ?? 0.0) || Longitude: \(country?.latlng[1] ?? 0.0)"
    }
}
