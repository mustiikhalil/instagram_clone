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
            self.images.append(Post(dictonary: dictonary))
            self.images.sort(by: { $0.timestamp > $1.timestamp})
            self.collectionView?.reloadData()
        }) { (err) in
            print(err)
        }
    }
    
    //MARK:- Fetches the user from the database
    func fetchUser() {
        fetchUserFromDatabase { (dictonary) in
            self.profile = Profile(dictonary: dictonary)
        }
    }
    
    fileprivate func fetchUserFromDatabase(onSuccess: @escaping ([String: Any])-> Void ) {
        
        guard let UID = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(UID).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictonary = snapshot.value as? [String: Any] else { return }
            onSuccess(dictonary)
        }) { (err) in
            print(err)
        }
    }
    
}
