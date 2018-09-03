//
//  UserProfileVC+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension UserProfileVC: UICollectionViewDelegateFlowLayout {
    
    func setupUI(withHeaderID header: CellType, cellID cell: CellType, secondaryCell: CellType)  {
        navigationController?.navigationBar.tintColor = .black
        collectionView?.backgroundColor = .white
        collectionView?.register(UserProfileCell.self, forCellWithReuseIdentifier: cell.ID)
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: secondaryCell.ID)
        collectionView?.register(UserProfileHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header.ID)
        if isDeviceOwner {
           setupLogOutButton()
        }
    }
    
    fileprivate func setupLogOutButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogout))
    }
	
	//MARK:- Header collection View functions
	
	override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CellType.header.ID, for: indexPath) as! UserProfileHeaderView
		if let profile = self.profile {
            header.headerItems = (images.count,0,0)
            header.delegate = self
			header.profile = profile
		}
		return header
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
		return CGSize(width: view.frame.width, height: 200)
	}
	
	
	// MARK:- Main Cells in the collection View
	
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return images.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isGridView {
            let width = (view.safeAreaLayoutGuide.layoutFrame.width - 2) / 3
            return CGSize(width: width, height: width)
        } else {
            var constantHeight: CGFloat = 40 + 16 // username and profile image view
            constantHeight += view.frame.width + 50 + 50
            return CGSize(width: collectionView.frame.width, height: constantHeight)
        }
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
		return 1
	}
	
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == images.count - 1 && !isFinishedPaging {
            fetchPagenatedPosts()
        }
        
        if isGridView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.cell.ID, for: indexPath) as! UserProfileCell
            cell.delegate = self
            cell.post = images[indexPath.item]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.secondaryCell.ID, for: indexPath) as! HomeCell
            cell.delegate = self
            var image = images[indexPath.item]
            image.user = profile
            cell.post = image
            return cell
        }
	}
	
    // fixes the problem if the collection view not resizing the view after two rotations
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
	
}

extension UserProfileVC: UserProfileHeaderDelegate, HomePostCellDelegate {
    func didTapComment(withPost: Post) {
        print("will do something")
    }
    
    func didTapUsername(withPost: Post) {
        print("will do something")
    }
    
    func didTapHearts(with Cell: HomeCell) {
        print("will do something")
    }
    
    func didChangeToListView() {
        isGridView = !isGridView
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func didChangeToGridView() {
        isGridView = !isGridView
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    
}
