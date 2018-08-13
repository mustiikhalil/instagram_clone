//
//  UserProfileHeaderView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class UserProfileHeaderView: UICollectionReusableView {
	
	var profile: Profile? {
		didSet{
			setupHeaderViewAfterRetrivingUserInformation()
		}
	}
	
	let profileImageView: MKImageView = {
		let iv = MKImageView()
		iv.backgroundColor = .red
		iv.layer.cornerRadius = 80/2
		return iv
	}()
	
	let usernameLabel: UILabel = {
		let label = UILabel()
		label.text = ""
		label.font = UIFont.boldSystemFont(ofSize: 14)
		return label
	}()
	
	let gridButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
		return button
	}()
	
	let listButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
		button.tintColor = UIColor(white: 0, alpha: 0.1)
		return button
	}()
	let bookmarkButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
		button.tintColor = UIColor(white: 0, alpha: 0.1)
		return button
	}()
	
	let postsLabel: MKLabel = {
		let label = MKLabel()
        label.setupLabelForProfileView(withNumber: "11", withText: "posts")
        return label
	}()
	let followersLabel: MKLabel = {
        let label = MKLabel()
        label.setupLabelForProfileView(withNumber: "11", withText: "followers")
        return label
	}()
	let followingLabel: MKLabel = {
        let label = MKLabel()
        label.setupLabelForProfileView(withNumber: "11", withText: "following")
        return label
	}()
	
	let editProfileButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Edit Profile", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.layer.borderColor = UIColor.lightGray.cgColor
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 2
		return button
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
	
		setupUI()
	}
	
	fileprivate func setupHeaderViewAfterRetrivingUserInformation() {
		guard let username = profile?.username else {return}
        guard let url = profile?.profileURL else {return}
		self.usernameLabel.text = username
		self.profileImageView.loadImage(url: url)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
