//
//  Scripts.swift
//  Extension
//
//  Created by Daniel Gx on 27/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation

struct UserScript {
    var title: String
    var body: String
}

class Script {
    static let shared = Script()
    var script = [UserScript]()
}
