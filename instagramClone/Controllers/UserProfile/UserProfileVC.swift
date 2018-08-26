//
//  UserProfileVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/30/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

class UserProfileVC: UICollectionViewController {

    var images: [Post] = []
    
	var profile: Profile? {
		didSet {
			self.navigationItem.title = profile?.username ?? ""
			self.collectionView?.reloadData()
		}
	}
    var userId: String?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI(withHeaderID: .header, cellID: .cell)
        fetchData()
	}
    
    @objc func handleLogout() {
        let alertController = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (_) in
            
            do {
                try Auth.auth().signOut()
                
                let navController = UINavigationController(rootViewController: LoginVC())
                self.present(navController, animated: true, completion: nil)
                
            } catch let SignOutErr {
                print(SignOutErr)
                print("Failed to sign out")
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension UserProfileVC: PostViewWillAppear {
    
    func pushToPostView(post: Post) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        let postVC = PostViewVC()
        postVC.post = post
        postVC.profile = profile
        navigationController?.pushViewController(postVC, animated: true)
    }
}
