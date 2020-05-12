//
//  AppCoordinator.swift
//  Project15
//
//  Created by Daniel Gx on 12/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        coordinate(to: mainCoordinator)
    }
}
