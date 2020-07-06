//
//  AppCoordinator.swift
//  ConsolidationMemeGeneration
//
//  Created by Daniel Gx on 03/07/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let initialCoordinator = InitialCoordinator(navigationController: navigationController)
        coordinate(to: initialCoordinator)
    }
}
