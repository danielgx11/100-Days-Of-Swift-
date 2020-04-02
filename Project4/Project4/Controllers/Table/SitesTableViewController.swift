//
//  SitesTableViewController.swift
//  Project4
//
//  Created by Daniel Gx on 31/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class SitesTableViewController: UITableViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: MainCoordinator?
    let mainViewController = MainViewController()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainViewController.websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell")
        
        cell?.textLabel?.text = mainViewController.websites[indexPath.row]
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        coordinator?.navegador(url: mainViewController.websites[indexPath.row])
    }
    
    // MARK: - Funcs
    
    func customizeNavigationController() {
        navigationItem.title = "Websites"
        navigationController?.navigationBar.tintColor = .black
    }
}
