//
//  CellType.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/11/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Foundation

enum CellType: String {
    case cell = "cellId"
    case header = "headerID"
    var ID: String {
        return self.rawValue
    }
}
