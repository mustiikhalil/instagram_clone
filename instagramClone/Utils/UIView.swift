//
//  UIView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/29/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension UIView {
	
	func anchor(leading: NSLayoutXAxisAnchor?, top: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, paddingLeading: CGFloat, paddingTop: CGFloat, paddingTailing: CGFloat, paddingBottom: CGFloat, width: CGFloat, height: CGFloat) {
		translatesAutoresizingMaskIntoConstraints = false
		if let topA = top {
			topAnchor.constraint(equalTo: topA, constant: paddingTop).isActive = true
		}
		
		if let leadingA = leading {
			leadingAnchor.constraint(equalTo: leadingA, constant: paddingLeading).isActive = true
		}
		
		if let bottomA = bottom {
			bottomAnchor.constraint(equalTo: bottomA, constant: paddingBottom).isActive = true
		}
		
		if let trailingA = trailing {
			trailingAnchor.constraint(equalTo: trailingA, constant: -paddingTailing).isActive = true
		}
		
		if height != 0 {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
		
		if width != 0 {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
	}
	
	func anchorCenter(X: NSLayoutXAxisAnchor?, Y: NSLayoutYAxisAnchor?, paddingX: CGFloat, paddingY: CGFloat, width: CGFloat, height: CGFloat) {
		
		if let x = X {
			centerXAnchor.constraint(equalTo: x, constant: paddingX).isActive = true
		}
		if let y = Y {
			centerYAnchor.constraint(equalTo: y, constant: paddingY).isActive = true
		}
		
		if width != 0 {
			widthAnchor.constraint(equalToConstant: width).isActive = true
		}
		
		if height != 0 {
			heightAnchor.constraint(equalToConstant: height).isActive = true
		}
	}
}
