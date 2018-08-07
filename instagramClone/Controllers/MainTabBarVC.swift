//
//  InstagramTabBarController.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarVC: UITabBarController, UITabBarControllerDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
		if Auth.auth().currentUser == nil {
			DispatchQueue.main.async {
				
				self.present(ViewControllersBuilder.Login.getNavigationController, animated: false, completion: nil)
			}
			return
		}
        
        self.delegate = self
		setupUI()
		setupViewControllers()
	}
	
	func setupUI() {
		tabBar.tintColor = .black
	}
	
    func setupViewControllers() {
        
        viewControllers = [ ViewControllersBuilder.Home.getNavigationController,
                            ViewControllersBuilder.Search.getNavigationController,
                            ViewControllersBuilder.Camera.getNavigationController,
                            ViewControllersBuilder.Hearts.getNavigationController,
                            ViewControllersBuilder.User.getNavigationController ]
        
        // Modify tab bar insets
        guard let items = tabBar.items else {return}
        
        items.forEach { (item) in
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
	}
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
    
        if index == 2 {
            present(ViewControllersBuilder.PhotoPicker.getNavigationController, animated: true, completion: nil)
            return false
        }
        return true
    }
}

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
