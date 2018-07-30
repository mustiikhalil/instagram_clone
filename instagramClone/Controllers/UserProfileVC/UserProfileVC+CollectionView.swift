//
//  UserProfileVC+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension UserProfileVC: UICollectionViewDelegateFlowLayout {
	
	func setupCollectionView() {
		collectionView?.backgroundColor = .white
		collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
		collectionView?.register(UserProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: header)
	}
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.header, for: indexPath) as! UserProfileHeaderView
		if let profile = self.profile {
			header.profile = profile
		}
		return header
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: view.frame.width, height: 200)
	}
	
}
