//
//  Coordinator.swift
//  Project15
//
//  Created by Daniel Gx on 12/05/20.
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
