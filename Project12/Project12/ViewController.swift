//
//  ViewController.swift
//  Project12
//
//  Created by Daniel Gx on 29/04/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        defaults.set(25, forKey: "Age")
        defaults.set(true, forKey: "UseFaceID")
        defaults.set(CGFloat.pi, forKey: "Pi")
        defaults.set("Daniel Gomes", forKey: "Name")
        defaults.set(Date(), forKey: "LastRun")
        let array = ["Hello", "World"]
        defaults.set(array, forKey: "SavedArray")
        let dict = ["Name" : "Daniel", "Country" : "UK"]
        defaults.set(dict, forKey: "SavedDict")
        let recoveredArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        let recoveredDict = defaults.object(forKey: "SavedDict") as? [String:String] ?? [String:String]()
    }


}

