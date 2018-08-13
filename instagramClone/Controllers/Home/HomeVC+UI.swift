//
//  HomeVC+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/13/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension HomeVC {
    
    func setupUI(withID cell: CellType) {
        collectionView?.backgroundColor = .white
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: cell.ID)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.cell.ID, for: indexPath) as! HomeCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 16 // username and profile image view
        height += view.frame.width + 50 + 60
        return CGSize(width: collectionView.frame.width, height: height)
    }
}
