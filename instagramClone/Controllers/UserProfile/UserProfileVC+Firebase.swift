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
            self.fetchPagenatedPosts()
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
    
    //MARK:- Fetches the posts from the database with pa
    func fetchPagenatedPosts() {
        guard let user = self.profile else { return }
        let ref = Database.database().reference().child("posts").child(user.UID)
        var query = ref.queryOrdered(byChild: "creationDate")
        
        if images.count > 0 {
            let key = images.last?.timestamp
            query = query.queryEnding(atValue: key)
        }
        query = query.queryLimited(toLast: self.maxPostFetch)
        databaseCall(query: query, user: user)
    }
    
    fileprivate func databaseCall(query: DatabaseQuery, user: Profile) {
        query.observeSingleEvent(of: .value, with: { (snapshot) in
            guard var allObjects = snapshot.children.allObjects as? [DataSnapshot] else {return}
            
            allObjects.reverse()
            
            if allObjects.count < Int(self.maxPostFetch) {
                self.isFinishedPaging = true
            }
        
            if self.images.count > 0 && allObjects.count > 0 {
                allObjects.removeFirst()
            }
            
            allObjects.forEach({ (snapshot) in
                guard let dictonary = snapshot.value as? [String: Any] else {return}
                self.images.append(Post(dictonary: dictonary, user: user, key: snapshot.key))
            })
            
            self.collectionView.reloadData()
            
        }) { (err) in
            print("failed to paginate", err)
        }
    }
}

