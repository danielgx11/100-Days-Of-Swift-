//
//  Created by Zafar Ivaev
//  https://medium.com/better-programming/leverage-the-coordinator-design-pattern-in-swift-5-cd5bb9e78e12
//
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
    func coordinate(to coordinator: Coordinator)
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
