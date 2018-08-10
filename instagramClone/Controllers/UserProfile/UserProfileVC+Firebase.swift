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
        fetchPostsFromDatabase(onSuccess: { (posts) in
            self.posts = posts
        }) { (err) in
            print(err)
            print("err Handling the request")
        }
    }
    
    func fetchPostsFromDatabase(onSuccess: @escaping ([Post]) -> Void, onFailure: @escaping (Error) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userRef = Database.database().reference().child("posts").child(uid)
        
        userRef.observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snap, string) in
            guard let dictonaries = snap.value as? [String: Any] else {return}
            
            let posts = dictonaries.map({ (key,value) -> Post in
                guard let dictornary = value as? [String: Any] else { return Post(url: "", caption: "", dimensions: Dimensions(width: 0, height: 0), image: nil) }
                return Post(dictonary: dictornary)
            })
            onSuccess(posts)
        }) { (err) in
            return err
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
