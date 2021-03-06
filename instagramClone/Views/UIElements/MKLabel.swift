//
//  MKLabel.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/31/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class MKLabel: UILabel {
	
    init() {
		super.init(frame: .zero)
	}
	override init(frame: CGRect) {
		super.init(frame: frame)
	}
    
    func setupLabelForProfileView(withNumber: Int, withText: String) {
        let customText = NSMutableAttributedString(string: "\(withNumber)\n", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        customText.append(NSMutableAttributedString(string: "\(withText)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        textAlignment = .center
        numberOfLines = 0
        attributedText = customText
    }
    
    func setupLabelForHomeViewWith(username: String) {
        text = username
        font = UIFont.boldSystemFont(ofSize: 14)
    }
        
    func setupLabelForNumberOfPosts(numberOfPosts: Int) {
        let customText = NSMutableAttributedString(string: "\(numberOfPosts) posts", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.gray])
        attributedText = customText
    }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
