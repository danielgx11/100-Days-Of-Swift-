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
    var counter = [SelectStormCounter]()
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        performSelector(inBackground: #selector(accessImages), with: nil)
        customizeNavigationController()
        recoverCounter()
        debugPrint(counter.count)
    }
    
    // MARK: - Methods
    
    func recoverCounter() {
        let defaults = UserDefaults.standard
        
        if let savedCounter = defaults.object(forKey: "counter") as? Data {
            let jsonDecoder = JSONDecoder()
            
            do {
                counter = try jsonDecoder.decode([SelectStormCounter].self, from: savedCounter)
            } catch {
                debugPrint("Failed to load counter")
            }
        }
    }
    
    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(counter) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "counter")
        } else {
            debugPrint("Failed to save counter")
        }
    }
    
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
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
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
        let count = SelectStormCounter(count: 1)
        counter.append(count)
        save()
        self.coordinator?.detailImage(to: pictures[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

