//
//  Photo.swift
//  ConsolidationIV - CollectionPhotos
//
//  Created by Daniel Gx on 02/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class Photo: NSObject {
    
    // MARK: - Properties
    
    var subtitle: String
    var image: String
    
    init(subtitle: String, image: String) {
        self.subtitle = subtitle
        self.image = image
    }
}
