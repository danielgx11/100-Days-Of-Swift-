//
//  InitialCoordinator.swift
//  ConsolidationMemeGeneration
//
//  Created by Daniel Gx on 03/07/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol InitialFlow: class {
    // TODO: Flow Methods
}

class InitialCoordinator: Coordinator, InitialFlow {
    
    // MARK: - Properties
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let initialCollectionView = InitialCollectionView()
        initialCollectionView.coordinator = self
        navigationController.pushViewController(initialCollectionView, animated: true)
    }
    
    // MARK: - Flow Methods
}
