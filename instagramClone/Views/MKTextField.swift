//
//  MKTextField.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/28/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class MKTextField: UITextField {
	
	init(placeholder text: PlaceholderTextField, color: UIColor, keyboardType type: UIKeyboardType = .default) {
		super.init(frame: .zero)
		placeholder = text.ID
		backgroundColor = color
		borderStyle = .roundedRect
		font = UIFont.systemFont(ofSize: 14)
		keyboardType = type
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)

	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

enum PlaceholderTextField: String {
	case Email, Password, Username
	var ID: String {
		get {
			return self.rawValue
		}
	}
}
