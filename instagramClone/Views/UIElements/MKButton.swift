//
//  MKButton.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/29/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class MKButton: UIButton {
	
	init(title: ButtonType, titleColor: UIColor, backgroundColor background: UIColor, raduis: CGFloat) {
		super.init(frame: .zero)
		titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		setTitle(title.ID(), for: .normal)
		setTitleColor(titleColor, for: .normal)
		backgroundColor = background
		layer.cornerRadius = raduis
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

enum ButtonType {
	case signup, login
	
	func ID() -> String {
		switch self {
			
		case .login:
			return "Log In"
		default:
			return "Sign Up"
		}
	}
}
