//
//  UIColor.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/28/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension UIColor {
    
	static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
		return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
	}
}
