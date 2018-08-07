//
//  ViewControllersBuilder.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/3/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit


enum ViewControllersBuilder {
    
    case Home, // Main view controller
    User, // User Profile view controller
    Search, // Search view controller
    PhotoSelector, // PhotoSelector view controller
    Hearts, // Hearts & Likes view controller
    Login, // login view controller
    SignUp,
    PhotoLibrary,
    Camera
    
    var getNavigationController: UINavigationController {
        
        switch self {
        case .Login:
            return registerNavControllers(VC: LoginVC())
        // user profile
        case .User:
            let layer = UICollectionViewFlowLayout()
            return registerNavControllers(VC: UserProfileVC(collectionViewLayout: layer), image: #imageLiteral(resourceName: "profile_selected"), unselectedImage: #imageLiteral(resourceName: "profile_unselected"))
            
        // Hearts and likes from users
        case .Hearts:
            return registerNavControllers(VC: HomeVC(), image: #imageLiteral(resourceName: "like_selected") ,unselectedImage: #imageLiteral(resourceName: "like_unselected"))
            
        // Search for users
        case .Search:
            return registerNavControllers(VC: HomeVC(), image: #imageLiteral(resourceName: "search_selected"), unselectedImage: #imageLiteral(resourceName: "search_unselected"))
            
        // Open Library
        case .PhotoSelector:
            return registerNavControllers(VC: HomeVC(), image: #imageLiteral(resourceName: "plus_unselected"), unselectedImage: #imageLiteral(resourceName: "plus_unselected"))
        
        // Photo selector library
        case .PhotoLibrary:
            let layer = UICollectionViewFlowLayout()
            return registerNavControllers(VC: LibraryPhotoSelectorVC(collectionViewLayout: layer), title: .library)
            
        case .Camera:
            return registerNavControllers(VC: HomeVC(), title: .camera)
        // Get the mainView
        default:
            let layer = UICollectionViewFlowLayout()
            return registerNavControllers(VC: UserProfileVC(collectionViewLayout: layer), image: #imageLiteral(resourceName: "home_selected"), unselectedImage: #imageLiteral(resourceName: "home_unselected"))
        }
    }
    
    var getViewController: UIViewController {
        switch self {
        case .SignUp:
            return SignUpVC()
        default:
            fatalError()
        }
    }
    
    fileprivate func registerNavControllers(VC: UIViewController, image: UIImage? = nil, unselectedImage: UIImage? = nil, title: WordDictionary? = nil) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: VC)
        if let selected = image {
            navController.tabBarItem.selectedImage = selected
        }
        if let unSelected = unselectedImage {
            navController.tabBarItem.image = unSelected
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
}


