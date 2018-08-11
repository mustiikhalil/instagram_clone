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
    
    var assetsArray: [Photo] = []
    var selectedImage: Photo?
    var header: LibraryPhotoSelectorHeaderCell?
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI(withHeaderID: .headerCell, cellID: .cellID)
        fetchPhotos()
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleSelection() {
        let sharePhotoController = SharingVC()
        sharePhotoController.hidesBottomBarWhenPushed = true
        sharePhotoController.image = header?.imageView.image
        navigationController?.pushViewController(sharePhotoController, animated: true)
    }
    
    func getImagesWithAsset(asset: PHAsset, ofSize size: CGSize, options: PHImageRequestOptions? = nil, onSuccess: @escaping (_ image: UIImage?) -> Void ) {
        let imageManager = PHImageManager.default()
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .default, options: options, resultHandler: { (image, info) in
           onSuccess(image)
        })
    }
    
    fileprivate func fetchPhotos() {
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetsFetchOptions())
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        DispatchQueue.global(qos: .background).async {
            allPhotos.enumerateObjects { (asset, count, stop) in
                self.getImagesWithAsset(asset: asset, ofSize: CGSize(width: 200, height: 200), options: options, onSuccess: { image in
                    self.addToArrays(image: image, asset: asset)
                    if count == allPhotos.count - 1 {
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                })
            }
        }
    }
    
    fileprivate func assetsFetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 30
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        return fetchOptions
    }
    
    fileprivate func addToArrays(image: UIImage?, asset: PHAsset) {
        if let image = image {
            self.assetsArray.append(Photo(image: image, asset: asset))
            if self.selectedImage == nil {
                self.selectedImage = Photo(image: image, asset: asset)
            }
        }
    }
    
}
