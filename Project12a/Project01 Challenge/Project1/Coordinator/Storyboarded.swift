//
//  Storyboarded.swift
//  Project1
//
//  Created by HackingWithSwift. -> https://www.hackingwithswift.com/articles/71/how-to-use-the-coordinator-pattern-in-ios-apps
//
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

// MARK: - Protocol

protocol Storyboarded {
    static func instantiate() -> Self
}

// MARK: - Extension

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(identifier: className)
    }
}
