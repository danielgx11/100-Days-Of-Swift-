//
//  Capital.swift
//  Project16
//
//  Created by Daniel Gx on 15/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit
import MapKit

class Capital: NSObject, MKAnnotation {

    // MARK: - Properties
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
    
}
