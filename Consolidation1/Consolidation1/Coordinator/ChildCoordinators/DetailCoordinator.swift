//
//  DetailCoordinator.swift
//  Consolidation1
//
//  Created by Daniel Gx on 27/03/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class DetailCoordinator: Coordinator {
    
    // MARK: - Variables
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    weak var parentCoordinator: MainCoordinator?
    var image = String()
    
    // MARK: - Funcs
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = DetailViewController.instantiate()
        vc.selectedImage = image
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
