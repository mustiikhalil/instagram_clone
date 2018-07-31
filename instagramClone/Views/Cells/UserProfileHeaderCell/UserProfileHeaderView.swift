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
			setupAfterNetworkCalls()
		}
	}
	
	let profileImageView: UIImageView = {
		let iv = UIImageView()
		iv.backgroundColor = .red
		iv.layer.cornerRadius = 80/2
		iv.clipsToBounds = true
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
	
	let postsLabel: UILabel = {
		return MKLabel(withNumber: "11", withText: "posts")
	}()
	let followersLabel: UILabel = {
		return MKLabel(withNumber: "11", withText: "followers")
	}()
	let followingLabel: UILabel = {
		return MKLabel(withNumber: "11", withText: "following")
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
	
	fileprivate func setupAfterNetworkCalls() {
		guard let imageData = profile?.imageData, let username = profile?.username else {return}
		self.usernameLabel.text = username
		self.profileImageView.image = UIImage(data: imageData)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
