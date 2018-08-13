//
//  UserProfileVC+Networking.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/2/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

extension UserProfileVC {
    
    func fetchPosts() {
        fetchOrderedPosts()
    }
    
    //MARK:- Fetches the posts from the database
    fileprivate func fetchOrderedPosts() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userRef = Database.database().reference().child("posts").child(uid)
        
        userRef.queryOrdered(byChild: "creationDate").observe(.childAdded, with: { (snapshot) in
            guard let dictonary = snapshot.value as? [String: Any] else {return}
            self.images.insert(Post(dictonary: dictonary), at: 0)
            self.collectionView?.reloadData()
        }) { (err) in
            print(err)
        }
    }
    
    //MARK:- Fetches the user from the database
    func fetchUser() {
        guard let currentUserUID = Auth.auth().currentUser?.uid else {return}
        Database.fetchUser(uid: currentUserUID) { (user) in
            self.profile = user
        }
    }
}

