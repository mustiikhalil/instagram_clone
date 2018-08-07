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
    var imagesArray: [UIImage] = []
    
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
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let allPhotos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        
        allPhotos.enumerateObjects { (asset, count, stop) in
            
            let imageManager = PHImageManager.default()
            let targetSize = CGSize(width: 350, height: 350)
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                if let image = image {
                    self.imagesArray.append(image)
                }
                if count == allPhotos.count - 1 {
                    self.collectionView?.reloadData()
                }
                
            })
        }
        
    }
    
}
