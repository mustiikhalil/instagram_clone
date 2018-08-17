//
//  HomeVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/11/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

class HomeVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellID"
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI(withID: .cell)
        fetchPosts()
    }
    
    func fetchPosts() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.fetchUser(uid: uid) { (user) in
            self.fetchPostsFromDatabaseWith(user: user, onSuccess: {
                self.collectionView?.reloadData()
            })
        }
    }
    
    fileprivate func fetchPostsFromDatabaseWith(user: Profile, onSuccess: @escaping ()-> Void) {
        let userRef = Database.database().reference().child("posts").child(user.UID)
        
        userRef.observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (values, key) in
            guard let dictonary = values.value as? [String: Any] else { return }
            dictonary.forEach({ (key, value) in
                guard let post = value as? [String: Any] else {return}
                self.posts.append(Post(dictonary: post, user: user))
//                self.posts.insert(Post(dictonary: post, user: user), at: 0)
            })
            onSuccess()
        }) { (err) in
            print(err)
        }
    }
}
