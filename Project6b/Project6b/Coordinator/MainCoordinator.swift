//
//  MainCoordinator.swift
//  Project6b
//
//  Created by HackingWithSwift. -> https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps
//
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
    
    // MARK: - Flow Methods
    
    func start() {
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

