//
//  HomeCell+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/13/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension HomeCell {
    
    func setupUI() {
        addSubview(imageView)
        addSubview(userProfileImageView)
        addSubview(usernameLabel)
        addSubview(optionsButton)
        addSubview(captionLabel)
        
        userProfileImageView.anchor(leading: leadingAnchor, top: topAnchor, trailing: nil, bottom: nil, paddingLeading: 8, paddingTop: 8, paddingTailing: 0, paddingBottom: 0, width: 40, height: 40)
        
        usernameLabel.anchor(leading: userProfileImageView.trailingAnchor, top: topAnchor, trailing: optionsButton.leadingAnchor, bottom: imageView.topAnchor, paddingLeading: 8, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
        
        optionsButton.anchor(leading: nil, top: topAnchor, trailing: trailingAnchor, bottom: imageView.topAnchor, paddingLeading: 8, paddingTop: 0, paddingTailing: 8, paddingBottom: 0, width: 44, height: 0)
        
        imageView.anchor(leading: leadingAnchor, top: userProfileImageView.bottomAnchor, trailing: trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 4, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
        imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        setupActionButtons()
        captionLabel.anchor(leading: leadingAnchor, top: heartsButton.bottomAnchor, trailing: trailingAnchor, bottom: bottomAnchor, paddingLeading: 8, paddingTop: 0, paddingTailing: 8, paddingBottom: 0, width: 0, height: 0)
        
    }
    
    fileprivate func setupActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [heartsButton,commentButton,shareButton])
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        addSubview(stackView)
        addSubview(bookmarkButton)
        stackView.anchor(leading: leadingAnchor, top: imageView.bottomAnchor, trailing: nil, bottom: nil, paddingLeading: 8, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 120, height: 50)
        bookmarkButton.anchor(leading: nil, top: imageView.bottomAnchor, trailing: trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 0, paddingTailing: 8, paddingBottom: 0, width: 40, height: 50)
    }
    
}
