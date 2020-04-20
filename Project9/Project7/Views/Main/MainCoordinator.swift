//
//  MainCoordinator.swift
//  Project7
//
//  Created by Daniel Gx on 08/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol MainFlow: class {
    func coordinateToTabBar()
    func coordinateToDetail(_ petition: Petition)
}

class MainCoordinator: Coordinator, MainFlow {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainTableView = MainTableView()
        mainTableView.coordinator = self
        navigationController.pushViewController(mainTableView, animated: false)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToTabBar() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
        coordinate(to: tabBarCoordinator)
    }
    
    func coordinateToDetail(_ petition: Petition) {
        let detailCoordinator = DetailCoordinator(navigationController: navigationController, petition: petition)
        coordinate(to: detailCoordinator)
    }
}
