//
//  ButtonType.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/13/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Foundation

enum ButtonType {
    case signup, login, heart, share, ribbon, comment, options
    
    func ID() -> String {
        switch self {
            
        case .login:
            return "Log In"
        default:
            return "Sign Up"
        }
    }
}

