//
//  HangmanCoordinator.swift
//  Consolidation III - Hangman Game
//
//  Created by Daniel Gx on 21/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol HangmanFlow: class {
    func coordinateToDetail()
}

class HangmanCoordinator: Coordinator, HangmanFlow {
    
    // MARK: - Properties
    
    var navigationController = UINavigationController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let hangmanGameView = HangmanGameView()
        hangmanGameView.coordinator = self
        navigationController.pushViewController(hangmanGameView, animated: true)
    }
    
    // MARK: - Flow Methods
    
    func coordinateToDetail() {
        //
    }
}
