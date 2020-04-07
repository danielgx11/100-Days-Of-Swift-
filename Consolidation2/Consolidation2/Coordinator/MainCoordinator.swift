//
//  MainCoordinator.swift
//  Consolidation2
//
//  Created by Daniel Gx on 07/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let shoppingListTableView = ShoppingListTableView.instantiate()
        shoppingListTableView.coordinator = self
        navigationController.pushViewController(shoppingListTableView, animated: true)
    }
    
    // MARK: - Flow Methods
}
