//
//  CountryFactsTableView.swift
//  ConsolidationCountries
//
//  Created by Daniel Gx on 14/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import Moya

class CountryFactsTableView: UITableViewController {
    
    // MARK: - Properties
    
    var countries = [Country]()
    let provider = MoyaProvider<CountryFacts>()

    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
        performSelector(inBackground: #selector(setAPI), with: nil)
    }
    
    
    // MARK: - Methods

    func customizeNavigationController() {
        title = "Country Facts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = UIColor.black
    }

    @objc func setAPI() {
        provider.request(.countries) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    debugPrint(try response.mapJSON())
                    self.countries = try JSONDecoder().decode(Array<Country>.self, from: response.data)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    debugPrint("DoCatch Error")
                }
            case .failure: debugPrint("Case Failure")
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! CountryCell
        cell.countryName.text = countries[indexPath.row].name
        cell.countryImage.image = UIImage(named: getFlagFileName(code: countries[indexPath.row].alpha2Code, type: .HD))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "countryDetail" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        let country = countries[indexPath.row]
        
        weak var destionationViewController = segue.destination as? DetailCountryView
        destionationViewController?.country = country
        let path = Bundle.main.path(forResource: getFlagFileName(code: countries[indexPath.row].alpha2Code, type: .HD), ofType: nil)!
        destionationViewController?.selectedCountryImage = UIImage(contentsOfFile: path)!
    }
}
