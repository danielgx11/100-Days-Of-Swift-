//
//  Utils.swift
//  ConsolidationNotes
//
//  Created by Daniel Gx on 08/06/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alertController(withTitle title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
}

