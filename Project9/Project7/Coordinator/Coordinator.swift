//
//  Coordinator.swift
//  Project7
//
//  Created by Daniel Gx on 08/04/20.
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
