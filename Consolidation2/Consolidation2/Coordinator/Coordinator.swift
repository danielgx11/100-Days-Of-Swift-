//
//  Coordinator.swift
//  Consolidation2
//
//  Created by Daniel Gx on 07/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController {get set}
    
    func start()
}
