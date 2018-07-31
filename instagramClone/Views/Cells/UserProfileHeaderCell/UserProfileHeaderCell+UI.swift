//
//  UserProfileHeaderCell+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/31/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension UserProfileHeaderView {
	
	func setupUI() {
		addSubview(profileImageView)
		addSubview(usernameLabel)
		addSubview(editProfileButton)
		
		profileImageView.anchor(leading: leadingAnchor, top: topAnchor, trailing: nil, bottom: nil, paddingLeading: 12, paddingTop: 12, paddingTailing: 0, paddingBottom: 0, width: 80, height: 80)
		setupBottomToolBar()
		
		usernameLabel.anchor(leading: leadingAnchor, top: profileImageView.bottomAnchor, trailing: trailingAnchor, bottom: gridButton.topAnchor, paddingLeading: 12, paddingTop: 4, paddingTailing: 12, paddingBottom: 0, width: 0, height: 0)
		setupUserStatesView()
		
		editProfileButton.anchor(leading: postsLabel.leadingAnchor, top: postsLabel.bottomAnchor, trailing: followingLabel.trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 2, paddingTailing: 0, paddingBottom: 0, width: 0, height: 34)
	}
	
	fileprivate func setupBottomToolBar() {
		
		let topDivider = UIView()
		topDivider.backgroundColor = UIColor.lightGray
		
		let bottomDivider = UIView()
		bottomDivider.backgroundColor = UIColor.lightGray
		
		let stackView = UIStackView(arrangedSubviews: [gridButton,listButton,bookmarkButton])
		stackView.alignment = .center
		stackView.distribution = .fillEqually
		addSubview(stackView)
		addSubview(topDivider)
		addSubview(bottomDivider)
		
		
		stackView.anchor(leading: leadingAnchor, top: nil, trailing: trailingAnchor, bottom: bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 50)
		
		topDivider.anchor(leading: stackView.leadingAnchor, top: nil, trailing: stackView.trailingAnchor, bottom: stackView.topAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0.5)
		bottomDivider.anchor(leading: stackView.leadingAnchor, top: stackView.bottomAnchor, trailing: stackView.trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0.5)
	}
	
	fileprivate func setupUserStatesView() {
		let stackView = UIStackView(arrangedSubviews: [postsLabel,followersLabel,followingLabel])
		stackView.distribution = .fillEqually
		addSubview(stackView)
		stackView.anchor(leading: profileImageView.trailingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: nil, paddingLeading: 12, paddingTop: 4, paddingTailing: 12, paddingBottom: 0, width: 0, height: 50)
	}
	
}
