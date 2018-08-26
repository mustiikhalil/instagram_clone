//
//  CommentCell.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/24/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class CommentCell: UICollectionViewCell {
    
    var comment: Comment? {
        didSet {
            guard let comment = comment else {return}
            setupCommentCell(comment: comment)
        }
    }
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.allowsEditingTextAttributes = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let profileImageView: MKImageView = {
        let iv = MKImageView()
        iv.backgroundColor = .blue
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textView)
        addSubview(profileImageView)
        profileImageView.anchor(leading: leadingAnchor, top: topAnchor, trailing: nil, bottom: nil, paddingLeading: 8, paddingTop: 8, paddingTailing: 0, paddingBottom: 0, width: 40, height: 40)
        textView.anchor(leading: profileImageView.trailingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, paddingLeading: 8, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
        
        profileImageView.layer.cornerRadius = 40 / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCommentCell(comment: Comment) {
        let attText = NSMutableAttributedString(string: comment.user.username, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        attText.append(NSAttributedString(string: " \(comment.comment)", attributes: [NSAttributedString.Key.font
            :UIFont.systemFont(ofSize: 14)]))
        textView.attributedText = attText
        profileImageView.loadImage(url: comment.user.profileURL)
    }
}
