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
		profileImageView.anchor(leading: leadingAnchor, top: topAnchor, trailing: nil, bottom: nil, paddingLeading: 12, paddingTop: 12, paddingTailing: 0, paddingBottom: 0, height: 80, width: 80)
		setupBottomToolBar()
		usernameLabel.anchor(leading: leadingAnchor, top: profileImageView.bottomAnchor, trailing: trailingAnchor, bottom: gridButton.topAnchor, paddingLeading: 12, paddingTop: 4, paddingTailing: 12, paddingBottom: 0, height: 0, width: 0)
		setupUserStatesView()
		addSubview(editProfileButton)
		editProfileButton.anchor(leading: profileImageView.trailingAnchor, top: postsLabel.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor, bottom: nil, paddingLeading: 12, paddingTop: 8, paddingTailing: 12, paddingBottom: 0, height: 34, width: 0)
	}
	
	fileprivate func setupBottomToolBar() {
		let stackView = UIStackView(arrangedSubviews: [gridButton,listButton,bookmarkButton])
		stackView.alignment = .center
		stackView.distribution = .fillEqually
		addSubview(stackView)
		stackView.anchor(leading: leadingAnchor, top: nil, trailing: trailingAnchor, bottom: bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, height: 50, width: 0)
	}
	
	fileprivate func setupUserStatesView() {
		let stackView = UIStackView(arrangedSubviews: [postsLabel,followersLabel,followingLabel])
		stackView.distribution = .fillEqually
		addSubview(stackView)
		stackView.anchor(leading: profileImageView.trailingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: nil, paddingLeading: 12, paddingTop: 4, paddingTailing: 12, paddingBottom: 0, height: 50, width: 0)
	}
	
}
