//
//  InstagramTabBarController.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarVC: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if Auth.auth().currentUser == nil {
			DispatchQueue.main.async {
				let navController = UINavigationController(rootViewController: LoginVC())
				self.present(navController, animated: false, completion: nil)
			}
			return
		}
		setupUI()
		setupViewControllers()
	}
	
	func setupUI() {
		tabBar.tintColor = .black
	}
	
	func setupViewControllers() {
		
		let layout = UICollectionViewFlowLayout()
		let userProfileVC = UserProfileVC(collectionViewLayout: layout)
		let navController = UINavigationController(rootViewController: userProfileVC)
		
		navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
		navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
		
		viewControllers = [navController, UIViewController()]
	}
	
}
