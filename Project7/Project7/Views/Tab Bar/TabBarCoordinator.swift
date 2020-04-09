//
//  TabBarCoordinator.swift
//  Project7
//
//  Created by Daniel Gx on 08/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        tabBarController.coordinator = self
        
        let mainNavigationController = UINavigationController()
        mainNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .recents, tag: 0)
        let mainCoordinator = MainCoordinator(navigationController: mainNavigationController)
        
        let popularNavigationController = UINavigationController()
        popularNavigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 1)
        let popularCoordinator = PopularCoordinator(navigationController: popularNavigationController)
        
        tabBarController.viewControllers = [mainNavigationController, popularNavigationController]
        
        tabBarController.modalPresentationStyle = .fullScreen
        navigationController.present(tabBarController, animated: false, completion: nil)
        
        coordinate(to: mainCoordinator)
        coordinate(to: popularCoordinator)
    }
    
}
