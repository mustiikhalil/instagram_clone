//
//  InstagramTabBarController.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tabBar.tintColor = .black
		let layout = UICollectionViewFlowLayout()
		let userProfileVC = UserProfileVC(collectionViewLayout: layout)
		let navController = UINavigationController(rootViewController: userProfileVC)
		
		navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
		navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
		
		viewControllers = [navController]
	}
}
