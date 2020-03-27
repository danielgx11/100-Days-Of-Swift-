//
//  MainCountriesTableView.swift
//  Consolidation1
//
//  Created by Daniel Gx on 27/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MainCountriesTableView: UITableViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: MainCoordinator?
    var countries = [String]()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCountries()
        customizeNavigationController()
    }
    
    // MARK: - Funcs
    
    func customizeNavigationController() {
        title = "Countries"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setCountries() {
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "russia", "us", "uk"]
    }
    
    // MARK: - TableView life cycle
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        
        cell.textLabel?.text = countries[indexPath.row]
        cell.imageView?.image = UIImage(named: countries[indexPath.row])
        cell.imageView?.layer.cornerRadius = 22
        cell.imageView?.clipsToBounds = true
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.detailView(image: countries[indexPath.row])
    }
    
}
