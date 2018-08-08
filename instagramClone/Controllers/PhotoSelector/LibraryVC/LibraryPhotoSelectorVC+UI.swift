//
//  PhotoSelectorVC+CollectionView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/7/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension LibraryPhotoSelectorVC: UICollectionViewDelegateFlowLayout {
    
    func setupUI() {
        setupNavigationBar()
        setupCollectionView()
    }
    
    
    //MARK:- Setup view
    
    fileprivate func setupCollectionView() {
        collectionView?.backgroundColor = .white
        collectionView?.register(LibraryPhotoSelectorHeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        collectionView?.register(LibraryPhotoSelectorCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    fileprivate func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDismiss))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleSelection))
    }
    
    
    //MARK:- Photo selection
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedImage = assetsArray[indexPath.item]
        self.collectionView?.reloadData()
    }
    
    //MARK:- Cell dequeueing
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! LibraryPhotoSelectorCell
        cell.item = assetsArray[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as! LibraryPhotoSelectorHeaderCell
        
        setupCell(cell: headerCell)
        
        return headerCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return assetsArray.count
    }
    
    
    //MARK:- Size of cells & layout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 3) / 4
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    fileprivate func setupCell(cell headerCell: LibraryPhotoSelectorHeaderCell) {
        if let highResImage = selectedImage?.highResImage {
            headerCell.item = highResImage
        } else {
            let size = CGSize(width: 600, height: 600)
            if let asset = selectedImage, let index = assetsArray.index(of: asset) {
                getImagesWithAsset(asset: assetsArray[index].asset, ofSize: size, onSuccess: {
                    image in
                    if let image = image {
                        DispatchQueue.main.async {
                            self.selectedImage?.highResImage = image
                            if let photo = self.selectedImage {
                                self.assetsArray[index] = photo
                            }
                            headerCell.item = image
                        }
                    }
                })
            }
        }
    }
    
}

