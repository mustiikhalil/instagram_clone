//
//  PhotoSelectorVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/7/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Photos

class LibraryPhotoSelectorVC: UICollectionViewController {
    
    let headerID = "HeaderID"
    let cellID = "CellID"
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchPhotos()
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSelection() {
        print("handling selection")
    }
    
    fileprivate func fetchPhotos() {
        print("fetching photos")
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 10
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        allPhotos.enumerateObjects { (asset, count, stop) in
            
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 350, height: 350)
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: nil, resultHandler: { (image, info) in
                <#code#>
            })
        }
    }
    
}
