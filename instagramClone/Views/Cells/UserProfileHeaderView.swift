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
			self.setupProfileImageFromURL()
		}
	}
	
	let profileImageView: UIImageView = {
		let iv = UIImageView()
		iv.backgroundColor = .red
		iv.layer.cornerRadius = 80/2
		iv.clipsToBounds = true
		return iv
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		backgroundColor = .blue
		addSubview(profileImageView)
		profileImageView.anchor(leading: leadingAnchor, top: topAnchor, trailing: nil, bottom: nil, paddingLeading: 12, paddingTop: 12, paddingTailing: 0, paddingBottom: 0, height: 80, width: 80)
	}
	
	fileprivate func setupProfileImageFromURL() {
		
		guard let profileURL = profile?.profileURL else { return }
		guard let url = URL(string: profileURL) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, urlResponse, err) in
			// do something
			if let err = err {
				print(err)
				print("problem fetching data")
				return
			}
			
			guard let data = data else {return}
			let image = UIImage(data: data)
			
			DispatchQueue.main.async {
				self.profileImageView.image = image
			}
		}.resume()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
