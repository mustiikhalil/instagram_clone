//
//  UIColor.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/28/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var instagramBlue: UIColor {
        get {
            return UIColor.rgb(red: 17, green: 164, blue: 237)
        }
    }
    static var instagramGrey: UIColor {
        get {
            return UIColor(white: 0, alpha: 0.1)
        }
    }
    
    /**
     RGB helper function that constructs the colors with the help of UIColor without the need to divide by 255
     
     - parameters:
        - red: the needed value of the Red Color
        - green: the needed value of the Green Color
        - blue: the needed value of the Blue Color
        - alpha: alpha defaults to 1 in case of not passing a required value
     
     - returns:
        UIColor constructed through the normal UIColor Constructor
     - important:
        No need to divide the colors by 255 since it's managed by the function
     */
	static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
		return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
	}
}
