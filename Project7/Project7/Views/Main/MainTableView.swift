//
//  MainTableView.swift
//  Project7
//
//  Created by Daniel Gx on 08/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MainTableView: UITableViewController {
    
    // MARK: - Properties
    
    var coordinator: MainFlow?
    var petitions = [Petition]()
        
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setAPI()
    }
    
    // MARK: - Methods
    
    func setAPI() {
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reusableCell")
        var cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reusableCell")
        cell.accessoryType = .disclosureIndicator
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.coordinateToDetail(petitions[indexPath.row])
    }
}
