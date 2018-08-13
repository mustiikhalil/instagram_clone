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
    
    func fetchData() {
        fetchUser {
            guard let uid = self.profile?.UID else {return}
            self.fetchOrderedPosts(withUID: uid)
        }
    }
   
    //MARK:- Fetches the posts from the database
    fileprivate func fetchOrderedPosts(withUID uid: String) {
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
    fileprivate func fetchUser(onSuccess: @escaping () -> Void) {
        let currentUserUID = userId ?? Auth.auth().currentUser?.uid ?? ""
        Database.fetchUser(uid: currentUserUID) { (user) in
            self.profile = user
            onSuccess()
        }
    }
}

