//
//  UIStackView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/28/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension UIStackView {
	
	func setupLoginLayout() {
		translatesAutoresizingMaskIntoConstraints = false
		distribution = .fillEqually
		axis = .vertical
		spacing = 10
	}
}
