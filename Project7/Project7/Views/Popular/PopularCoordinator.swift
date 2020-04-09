//
//  PopularCoordinator.swift
//  Project7
//
//  Created by Daniel Gx on 09/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol PopularFlow {
    func coordinateToDetail(_ petition: Petition)
}

class PopularCoordinator: Coordinator, PopularFlow {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let popularViewController = PopularViewController()
        popularViewController.coordinator = self
        navigationController.pushViewController(popularViewController, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToDetail(_ petition: Petition) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, petition: petition)
        coordinate(to: detailCoordinator)
    }
}
