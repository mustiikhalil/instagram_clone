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
	var profile: Profile? {
		didSet {
			self.navigationItem.title = profile?.username ?? ""
			self.collectionView?.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupCollectionView()
		fetchUser()
		setupLogOutButton()
	}
	
	func fetchUser() {
		fetchUserFromDatabase { (dictonary) in
			self.fetchProfileImageForUser(dictonary: dictonary, onSuccess: { (profile) in
				self.profile = profile
			})
		}
	}
	
	fileprivate func fetchUserFromDatabase(onSuccess: @escaping ([String: Any])-> Void ) {
		
		guard let UID = Auth.auth().currentUser?.uid else { return }
		Database.database().reference().child("users").child(UID).observeSingleEvent(of: .value, with: { (snapshot) in
			guard let dictonary = snapshot.value as? [String: Any] else { return }
			onSuccess(dictonary)
		}) { (err) in
			print(err)
		}
	}
	
	fileprivate func fetchProfileImageForUser(dictonary: [String: Any], onSuccess: @escaping (Profile)-> Void ) {
		
		guard let userUrl = dictonary["profileLink"] as? String else {return}
		guard let url = URL(string: userUrl) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, urlResponse, err) in
			
			if let err = err {
				print(err)
				print("problem fetching data")
				return
			}
			
			guard let data = data else {return}

			DispatchQueue.main.async {
				let profile = Profile(dictonary: dictonary, imageData: data)
				onSuccess(profile)
			}
		}.resume()
	}
	
	fileprivate func setupLogOutButton() {
		navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
	}
	
	@objc fileprivate func handleLogout() {
		let alertController = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .actionSheet)
		
		alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (_) in
			
			do {
				try Auth.auth().signOut()
				
				let navController = UINavigationController(rootViewController: LoginVC())
				self.present(navController, animated: true, completion: nil)
				
			} catch let SignOutErr {
				print(SignOutErr)
				print("Failed to sign out")
			}
		}))
		
		alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
		
		present(alertController, animated: true, completion: nil)
	}
}
