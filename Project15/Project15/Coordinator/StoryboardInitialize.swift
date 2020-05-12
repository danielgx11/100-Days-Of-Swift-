//
//  StoryboardInitialize.swift
//  Project15
//
//  Created by Daniel Gx on 12/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

protocol StoryboardInitialize {
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitialize where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func initFromStoryboard(name: String = "Main") -> Self {
        let storyboard = UIStoryboard(name: name, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
