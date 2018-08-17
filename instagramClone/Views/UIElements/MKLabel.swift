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
    
    func setupLabelForProfileView(withNumber: String, withText: String) {
        let customText = NSMutableAttributedString(string: "\(withNumber)\n", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        customText.append(NSMutableAttributedString(string: "\(withText)", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        textAlignment = .center
        numberOfLines = 0
        attributedText = customText
    }
    
    func setupLabelForHomeViewWith(username: String) {
        text = username
        font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    func setupLabelForHomeViewWith(caption: String, username: String, time: Double) {
        let customText = NSMutableAttributedString(string: "\(username) ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        
        customText.append(NSAttributedString(string: caption, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)]))
        
        customText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 4)]))
        
        customText.append(NSAttributedString(string: "\(Date(timeIntervalSince1970: time).timeAgoDisplay())", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        numberOfLines = 0
        attributedText = customText
    }
    
    func setupLabelForNumberOfPosts(numberOfPosts: Int) {
        let customText = NSMutableAttributedString(string: "\(numberOfPosts) posts", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray])
        attributedText = customText
    }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
