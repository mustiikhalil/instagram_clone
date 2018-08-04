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
				
				self.present(ViewControllersBuilder.Login.getViewController(), animated: false, completion: nil)
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
        
        let homeNavController = ViewControllersBuilder.Home.getViewController(layout: UICollectionViewFlowLayout())
        let searchNavController = ViewControllersBuilder.Search.getViewController()
        let plusNavController = ViewControllersBuilder.Camera.getViewController()
        let heartsNavController = ViewControllersBuilder.Hearts.getViewController()
        let userProfileNavController = ViewControllersBuilder.User.getViewController(layout: UICollectionViewFlowLayout())
        
		viewControllers = [ homeNavController,
                            searchNavController,
                            plusNavController,
                            heartsNavController,
                            userProfileNavController
        ]
        
        // Modify tab bar insets
        guard let items = tabBar.items else {return}
        
        items.forEach { (item) in
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
	}
	
}

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
