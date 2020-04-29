//
//  Person.swift
//  Project10
//
//  Created by Daniel Gx on 23/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class Person: NSObject {

    // MARK: - Properties
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
