//
//  MainCoordinator.swift
//  Project10
//
//  Created by Daniel Gx on 22/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol MainFlow: class {
    //
}

class MainCoordinator: Coordinator, MainFlow {
    
    // MARK: - Properties
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainViewController = MainViewController.initFromStoryboard(name: "Main")
        mainViewController.coordinator = self
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    // MARK: - Flow Methods
}
