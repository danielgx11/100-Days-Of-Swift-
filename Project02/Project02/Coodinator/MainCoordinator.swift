//
//  MainCoordinator.swift
//  Project02
//
//  Created by Daniel Gx on 26/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Variables
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    // MARK: - Funcs
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController.instantiate()
        mainViewController.coordinator = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
}
