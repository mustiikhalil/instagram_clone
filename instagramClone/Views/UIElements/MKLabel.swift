//
//  MKLabel.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/31/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class MKLabel: UILabel {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		text = "12\nposts"
		textAlignment = .center
		numberOfLines = 0
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
