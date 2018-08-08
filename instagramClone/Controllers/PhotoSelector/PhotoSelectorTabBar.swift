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
        
        let libraryPhotoSelectorVC = ViewControllersBuilder.PhotoLibrary.getNavigationController
        let cameraPhotoSelectorVC = ViewControllersBuilder.Camera.getNavigationController
        
        viewControllers = [ libraryPhotoSelectorVC,
                            cameraPhotoSelectorVC ]
    }
    
}
