//
//  ShoppingListTableView.swift
//  Consolidation2
//
//  Created by Daniel Gx on 07/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class ShoppingListTableView: UITableViewController, Storyboarded {
    
    // MARK: - Properties
    
    weak var coordinator: MainCoordinator?
    var shoppingList = [String]()
        
    // MARK: - Actions
    
    @objc func addProductTapped() {
        let ac = UIAlertController(title: "Enter product", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak ac] _ in
            guard let product = ac?.textFields?[0].text else { return }
            self?.submit(product)
        }
        
        ac.addAction(submitAction)
        present(ac, animated: true)
    }
    
    @objc func deleteListTapped() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
    
    @objc func shareTapped(_ sender: UIButton) {
        let list = shoppingList.joined(separator: "\n")
        
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeNavigationController()
        customizeToolbarItems()
    }
    
    // MARK: - Methods
    
    func customizeToolbarItems() {
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped(_:))))
        toolbarItems = items
        navigationController?.isToolbarHidden = false
    }
    
    func customizeNavigationController() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addProductTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteListTapped))
        title = "Shopping list"
    }
    
    func submit(_ product: String) {
        let selectedProduct = product.lowercased()
        
        if isPossible(selectedProduct) {
            shoppingList.insert(selectedProduct, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else {
            let ac = UIAlertController(title: "Warning", message: "Empty submit, try type a valid word!", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true)
        }
    }
    
    func isPossible(_ product: String) -> Bool {
        if product.count > 0 {
            return true
        }
        return false
    }
}

// MARK: - Table view data source

extension ShoppingListTableView {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableCell")
        cell?.textLabel?.text = shoppingList[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
