//
//  Person.swift
//  Project10
//
//  Created by Daniel Gx on 23/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class Person: NSObject, NSCoding {
    
    // MARK: - Properties
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
    
    func encode(with aCoder: NSCoder) { /// Save objects
        aCoder.encode(name, forKey: "name")
        aCoder.encode(image, forKey: "image")
    }
    
    required init?(coder aDecoder: NSCoder) { /// Load objects
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? String ?? ""
    }
}
