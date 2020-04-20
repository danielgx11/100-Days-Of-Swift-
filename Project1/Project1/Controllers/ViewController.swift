//
//  ViewController.swift
//  Project1
//
//  Created by Daniel Gx on 25/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, Storyboarded {
    
    // MARK: - Variables
    
    weak var coordinator: MainCoordinator?
    var pictures = [String]()
    
    // MARK: - Outlets
    
    
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(accessImages), with: nil)
        customizeNavigationController()
    }
    
    // MARK: - Funcs
    
    func customizeNavigationController() {
        title = "Storm View"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func accessImages() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }
        }
        
        performSelector(onMainThread: #selector(tableView.reloadData), with: nil, waitUntilDone: true)
        
    }
    
    // MARK: - TableView life cycle
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        
        cell.textLabel?.text = pictures[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.coordinator?.detailImage(to: pictures[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

