//
//  PopularViewController.swift
//  Project7
//
//  Created by Daniel Gx on 09/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class PopularViewController: UIViewController {
    
    // MARK: - Properties
    
    var coordinator: PopularFlow?
    var petitions = [Petition]()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setAPI()
        title = "Most popular"
    }
    
    // MARK: - Methods
    
    func setAPI() {
        let urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        showError()
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            tableView.reloadData()
        }
    }
    
    func showError() {
        let ac = UIAlertController(title: "Loading error", message: "There was a problem loading the feed; please check your connection and try again.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
        present(ac, animated: true)
    }

}

// MARK: - UI Setup

extension PopularViewController {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
                                     tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
                                    ])
    }
}

// MARK: - Table view data source

extension PopularViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reusableCell")
        var cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "reusableCell")
        cell.accessoryType = .disclosureIndicator
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.coordinateToDetail(petitions[indexPath.row])
    }
}
