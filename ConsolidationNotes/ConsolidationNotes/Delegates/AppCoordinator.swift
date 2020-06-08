//
//  Created by Zafar Ivaev
//  https://medium.com/better-programming/leverage-the-coordinator-design-pattern-in-swift-5-cd5bb9e78e12
//
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
        
        let notesCoordinator = NotesCoordinator(navigationController: navigationController)
        coordinate(to: notesCoordinator)
    }
}
