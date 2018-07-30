//
//  UserProfileVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UICollectionViewController {
	
	let header = "headerID"
	let cellID = "idCell"
	var profile: Profile?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionView()
		setupUI()
	}
	
	func setupUI() {
		fetchUser {
			self.navigationItem.title = self.profile?.username ?? ""
			self.collectionView?.reloadData()
		}
	}
	
	fileprivate func fetchUser(onSuccess: @escaping ()->Void) {
		guard let UID = Auth.auth().currentUser?.uid else { return }
		
		Database.database().reference().child("users").child(UID).observeSingleEvent(of: .value, with: { (snapshot) in
			
			guard let dictonary = snapshot.value as? [String: Any] else { return }
			self.profile = Profile(dictonary: dictonary)
			onSuccess()
		}) { (err) in
			print(err)
		}
	}

}
