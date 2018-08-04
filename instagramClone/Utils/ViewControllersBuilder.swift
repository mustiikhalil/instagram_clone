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
         Camera, // Camera view controller
         Hearts, // Hearts & Likes view controller
         Login // login view controller
    
    func getViewController(layout: UICollectionViewFlowLayout? = nil) -> UINavigationController {
        
        switch self {
            case .Login:
                return registerNavControllers(VC: LoginVC())
            
            // user profile
            case .User:
                
                guard let layer = layout else {fatalError()}
                return registerNavControllers(VC: UserProfileVC(collectionViewLayout: layer), image: #imageLiteral(resourceName: "profile_selected"), unselectedImage: #imageLiteral(resourceName: "profile_unselected"))
            
            // Hearts and likes from users
            case .Hearts:
                return registerNavControllers(VC: HomeVC(), image: #imageLiteral(resourceName: "like_selected") ,unselectedImage: #imageLiteral(resourceName: "like_unselected"))
            
            // Search for users
            case .Search:
                return registerNavControllers(VC: HomeVC(), image: #imageLiteral(resourceName: "search_selected"), unselectedImage: #imageLiteral(resourceName: "search_unselected"))
            
            // Open Photos
            case .Camera:
                return registerNavControllers(VC: HomeVC(), image: #imageLiteral(resourceName: "plus_unselected"), unselectedImage: #imageLiteral(resourceName: "plus_unselected"))
            
            // Get the mainView
            default:
                guard let layer = layout else {fatalError()}
                return registerNavControllers(VC: UserProfileVC(collectionViewLayout: layer), image: #imageLiteral(resourceName: "home_selected"), unselectedImage: #imageLiteral(resourceName: "home_unselected"))
        }
    }
    
    private func registerNavControllers(VC: UIViewController, image: UIImage? = nil, unselectedImage: UIImage? = nil) -> UINavigationController {
        
        let navController = UINavigationController(rootViewController: VC)
        if let selected = image {
            navController.tabBarItem.selectedImage = selected
        }
        if let unSelected = unselectedImage {
            navController.tabBarItem.image = unSelected
        }
        return navController
    }
    
}


