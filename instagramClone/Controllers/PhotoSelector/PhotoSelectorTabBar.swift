//
//  PhotoSelectorTabBar.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/7/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class PhotoSelectorTabBar: UITabBarController {
    
    let library = "Library"
    let camera = "Camera"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photoPickerVC = setupVC(vc: ViewControllersBuilder.PhotoPicker.getNavigationController, title: library)
        let cameraVC = setupVC(vc: ViewControllersBuilder.PhotoPicker.getNavigationController, title: camera)
        
        viewControllers = [photoPickerVC,cameraVC]
    }
    
    func setupVC(vc: UIViewController, title: String) -> UIViewController {
        vc.tabBarItem.title = title
        vc.tabBarItem.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.lightGray,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14),
            ], for: .normal)
        vc.tabBarItem.setTitleTextAttributes([
            NSAttributedStringKey.foregroundColor: UIColor.black,
            NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14),
            ], for: .selected)
        vc.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -14)
        return vc
    }
}
