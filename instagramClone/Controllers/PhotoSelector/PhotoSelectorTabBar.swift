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
        
        let libraryPhotoSelectorVC = registerNavControllers(VC: LibraryPhotoSelectorVC(collectionViewLayout: UICollectionViewFlowLayout()), image: nil, unselectedImage: nil, title: .library)
        let cameraPhotoSelectorVC = registerNavControllers(VC: CameraVC(), image: nil, unselectedImage: nil, title: .camera)
        viewControllers = [ libraryPhotoSelectorVC,
                            cameraPhotoSelectorVC ]
    }
}
