//
//  DetailCoordinator.swift
//  Project7
//
//  Created by Daniel Gx on 09/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol DetailFlow {
    func dismissDetail()
}

class DetailCoordinator: Coordinator, DetailFlow {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    let petition: Petition?
    
    init(navigationController: UINavigationController, petition: Petition) {
        self.navigationController = navigationController
        self.petition = petition
    }
    
    func start() {
        let detailViewController = DetailViewController()
        detailViewController.detailItem = petition
        detailViewController.coordinator = self
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func dismissDetail() {
        //
    }
    
}
