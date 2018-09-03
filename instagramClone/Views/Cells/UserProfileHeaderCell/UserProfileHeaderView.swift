//
//  UserProfileHeaderView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

protocol UserProfileHeaderDelegate {
    
    func didChangeToListView()
    
    /**
     Changes to gridView when Toggled
    */
    func didChangeToGridView()
}

class UserProfileHeaderView: UICollectionReusableView {
	
	var profile: Profile? {
		didSet{
			setupHeaderViewAfterRetrivingUserInformation()
		}
	}
    
    var headerItems: (Int,Int,Int)? {
        didSet {
            postsLabel.setupLabelForProfileView(withNumber: headerItems?.0 ?? 0, withText: "posts")
            followersLabel.setupLabelForProfileView(withNumber: headerItems?.1 ?? 0, withText: "followers")
            followingLabel.setupLabelForProfileView(withNumber: headerItems?.2 ?? 0, withText: "followers")
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
	
	lazy var gridButton: UIButton = {
		let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(handleChangeToGridView), for: .touchUpInside)
		button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
		return button
	}()
	
	lazy var listButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.addTarget(self, action: #selector(handleChangeToListView), for: .touchUpInside)
		button.tintColor = .instagramGrey
		return button
	}()
	let bookmarkButton: UIButton = {
		let button = UIButton(type: .system)
		button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
		button.tintColor = .instagramGrey
		return button
	}()
	
	let postsLabel: MKLabel = {
		let label = MKLabel()
        label.setupLabelForProfileView(withNumber: 0, withText: "posts")
        return label
	}()
	let followersLabel: MKLabel = {
        let label = MKLabel()
        label.setupLabelForProfileView(withNumber: 0, withText: "followers")
        return label
	}()
	let followingLabel: MKLabel = {
        let label = MKLabel()
        label.setupLabelForProfileView(withNumber: 0, withText: "following")
        return label
	}()
	
	lazy var editProfileButton: UIButton = {
		let button = UIButton(type: .system)
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
		button.layer.borderWidth = 1
		button.layer.cornerRadius = 2
        button.addTarget(self, action: #selector(handleEditOrFollow), for: .touchUpInside)
		return button
	}()
    
    var delegate: UserProfileHeaderDelegate?
    
    @objc func handleChangeToListView() {
        toggleColorForButtons(gridColor: .instagramGrey, listColor: .instagramBlue)
        delegate?.didChangeToListView()
    }
    
    @objc func handleChangeToGridView() {
        toggleColorForButtons(gridColor: .instagramBlue, listColor: .instagramGrey)
        delegate?.didChangeToGridView()
    }
    
    fileprivate func toggleColorForButtons(gridColor: UIColor, listColor: UIColor) {
        gridButton.tintColor = gridColor
        listButton.tintColor = listColor
    }
	
    @objc func handleEditOrFollow() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let user = profile?.UID else {return}
        let ref = Database.database().reference().child("following").child(uid)
        let values = [user:1]
        if editProfileButton.titleLabel?.text?.lowercased() == "follow" {
            ref.updateChildValues(values) { (err, refDatabase) in
                if let err = err {
                    print("failed to follow", err)
                    return
                }
                self.setupButton(type: .Unfollow)
            }
        } else if editProfileButton.titleLabel?.text?.lowercased() == "unfollow" {
            ref.child(user).removeValue { (err, data) in
                if let err = err {
                    print("couldn't unfollow", err)
                    return
                }
                print("unfollow")
                self.setupButton(type: .Follow)
            }
        } else {
            print("edit profile")
        }
    }
	
	fileprivate func setupHeaderViewAfterRetrivingUserInformation() {
		guard let user = profile else {return}
        guard let auth = Auth.auth().currentUser?.uid else {return}
		self.usernameLabel.text = user.username
		self.profileImageView.loadImage(url: user.profileURL)
        
        if auth == user.UID {
            setupButton(type: .Edit)
        } else {
            Database.database().reference().child("following").child(auth).child(user.UID).observeSingleEvent(of: .value, with: { (snapshot) in
                if let isFollowing = snapshot.value as? Int, isFollowing == 1 {
                    self.setupButton(type: .Unfollow)
                } else {
                    self.setupButton(type: .Follow)
                }
            }) { (err) in
                print("couldn't get the value", err)
            }
        }
	}
    
    fileprivate func setupButton(type: ProfileHeaderButtonType) {
        editProfileButton.setTitle(type.title, for: .normal)
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
    case Edit = "Edit Profile"
    case Follow, Unfollow
    
    var title: String {
        return self.rawValue
    }
    var getColor: UIColor {
        switch self {
        case .Edit, .Unfollow:
            return UIColor.white
        case .Follow:
            return .instagramBlue
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
