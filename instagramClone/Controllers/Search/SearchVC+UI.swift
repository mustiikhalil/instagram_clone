//
//  SearchVC+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/13/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension SearchVC {
    
    func setupUI() {
        collectionView?.backgroundColor = .white
        collectionView?.register(SearchCells.self, forCellWithReuseIdentifier: CellType.cell.ID)
        guard let navBar = navigationController?.navigationBar else {return}
        navBar.addSubview(searchBar)
        searchBar.anchor(leading: navBar.leadingAnchor, top: navBar.safeAreaLayoutGuide.topAnchor, trailing: navBar.trailingAnchor, bottom: navBar.bottomAnchor, paddingLeading: 8, paddingTop: 0, paddingTailing: 8, paddingBottom: 0, width: 0, height: 0)
        collectionView?.alwaysBounceVertical = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredUsers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.cell.ID, for: indexPath) as! SearchCells
        cell.user = filteredUsers[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 66)
    }
}
