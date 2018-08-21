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
				
				self.present(LoginVC(), animated: false, completion: nil)
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
        let layout = UICollectionViewFlowLayout()
        let homeVC = registerNavControllers(VC: HomeVC(collectionViewLayout: layout), image: #imageLiteral(resourceName: "home_selected"), unselectedImage: #imageLiteral(resourceName: "home_unselected"))
        let userVC = registerNavControllers(VC: UserProfileVC(collectionViewLayout: layout), image: #imageLiteral(resourceName: "profile_selected"), unselectedImage: #imageLiteral(resourceName: "profile_unselected"))
        let heartsVC = registerNavControllers(VC: JustAView(), image: #imageLiteral(resourceName: "like_selected") ,unselectedImage: #imageLiteral(resourceName: "like_unselected"))
        let searchVC = registerNavControllers(VC: SearchVC(collectionViewLayout: layout), image: #imageLiteral(resourceName: "search_selected"), unselectedImage: #imageLiteral(resourceName: "search_unselected"))
        let cameraVC = registerNavControllers(VC: JustAView(), image: #imageLiteral(resourceName: "plus_unselected"), unselectedImage: #imageLiteral(resourceName: "plus_unselected"))
        viewControllers = [homeVC, searchVC, cameraVC, heartsVC, userVC ]
        
        // Modify tab bar insets
        guard let items = tabBar.items else {return}
        
        items.forEach { (item) in
            item.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        }
	}
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.index(of: viewController)
    
        if index == 2 {
            present(PhotoSelectorTabBar(), animated: true, completion: nil)
            return false
        }
        return true
    }
    
}

class JustAView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

func registerNavControllers(VC: UIViewController, image: UIImage? = nil, unselectedImage: UIImage? = nil, title: WordDictionary? = nil) -> UINavigationController {
    
    let navController = UINavigationController(rootViewController: VC)
    if let selected = image {
        navController.tabBarItem.selectedImage = selected.withRenderingMode(.alwaysOriginal)
    }
    if let unSelected = unselectedImage {
        navController.tabBarItem.image = unSelected.withRenderingMode(.alwaysOriginal)
    }
    if let title = title {
        navController.tabBarItem.title = title.rawValue
        navController.tabBarItem.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.lightGray,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14),
            ], for: .normal)
        navController.tabBarItem.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14),
            ], for: .selected)
        navController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -14)
    }
    return navController
}
