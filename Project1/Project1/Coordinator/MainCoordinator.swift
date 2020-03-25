//
//  MainCoordinator.swift
//  Project1
//
//  Created by HackingWithSwift. -> https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps
//
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
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func detailImage(to name: String) {
        let vc = DetailViewController.instantiate()
        vc.selectedImage = name
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}

