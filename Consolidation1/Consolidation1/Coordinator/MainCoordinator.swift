//
//  MainCoordinator.swift
//  Consolidation1
//
//  Created by Daniel Gx on 27/03/20.
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
        let vc = MainCountriesTableView.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func detailView(image: String) {
        let child = DetailCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.parentCoordinator = self
        child.image = image
        child.start()
    }
}
