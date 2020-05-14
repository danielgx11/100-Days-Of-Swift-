//
//  Flag.swift
//  ConsolidationCountries
//
//  Created by Daniel Gx on 14/05/20.
//  Copyright © 2020 Daniel Gx. All rights reserved.
//

import Foundation

let prefixHD = "flag_hd_"
let flagExt = ".png"

func getFlagFileName(code: String, type: FlagType) -> String {
    return getFlagPrefix(type: type) + code + flagExt
}

func getFlagPrefix(type: FlagType) -> String {
    switch type {
    case .HD: return prefixHD
    }
}

enum FlagType {
    case HD
}
