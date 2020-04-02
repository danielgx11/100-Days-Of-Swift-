//
//  MainCoordinator.swift
//  Project4
//
//  Created by Daniel Gx on 30/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SitesTableViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func navegador(url: String) {
        let vc = MainViewController.instantiate()
        vc.selectedURL = url
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
