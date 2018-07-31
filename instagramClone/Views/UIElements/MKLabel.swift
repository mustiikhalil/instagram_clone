//
//  MKLabel.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/31/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class MKLabel: UILabel {
	
	init(withNumber: String, withText: String) {
		super.init(frame: .zero)
		let customText = NSMutableAttributedString(string: "\(withNumber)\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
		
		customText.append(NSMutableAttributedString(string: "\(withText)", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
		textAlignment = .center
		numberOfLines = 0
		attributedText = customText
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
		
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
