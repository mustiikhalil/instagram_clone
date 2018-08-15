//
//  UserProfileHeaderView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

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
	
	lazy var editProfileButton: UIButton = {
		let button = UIButton(type: .system)
		button.setTitle("Edit Profile", for: .normal)
		button.setTitleColor(.black, for: .normal)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 2
        button.addTarget(self, action: #selector(handleEditOrFollow), for: .touchUpInside)
		return button
	}()
	
    @objc func handleEditOrFollow() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let user = profile?.UID else {return}
        let ref = Database.database().reference().child("following").child(uid)
        let values = [user:1]
        ref.updateChildValues(values) { (err, refDatabase) in
            if let err = err {
                print("failed to follow", err)
                return
            }
            self.setupButton(title: ProfileHeaderButtonType.Unfollow.title, type: .Unfollow)
        }
    }
	
	fileprivate func setupHeaderViewAfterRetrivingUserInformation() {
		guard let user = profile else {return}
        guard let auth = Auth.auth().currentUser?.uid else {return}
		self.usernameLabel.text = user.username
		self.profileImageView.loadImage(url: user.profileURL)
        if auth == user.UID {
            setupButton(title: "Edit Profile", type: .Edit)
        } else {
            setupButton(title: "Follow", type: .Follow)
        }
	}
    
    fileprivate func setupButton(title: String, type: ProfileHeaderButtonType) {
        editProfileButton.setTitle(title, for: .normal)
        editProfileButton.setTitleColor(type.titleColor, for: .normal)
        editProfileButton.backgroundColor = type.getColor
        editProfileButton.layer.borderColor = type.border.cgColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

enum ProfileHeaderButtonType: String {
    case Edit, Follow, Unfollow
    
    var title: String {
        return self.rawValue
    }
    var getColor: UIColor {
        switch self {
        case .Edit, .Unfollow:
            return UIColor.white
        case .Follow:
            return UIColor.rgb(red: 17, green: 164, blue: 237)
        }
    }
    
    var titleColor: UIColor {
        switch self {
        case .Edit, .Unfollow:
            return .black
        default:
            return .white
        }
    }
    var border: UIColor {
        switch self {
        case .Edit, .Unfollow:
            return UIColor.lightGray
        default:
            return UIColor.clear
        }
    }
}
