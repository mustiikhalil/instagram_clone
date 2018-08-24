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
        fetch()
    }
    
    func fetch() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        getFollowedUsers(uid: uid) { (dictonary) in
            for (key, _) in dictonary {
                self.fetchPosts(uid: key)
            }
        }
    }
    
    func fetchPosts(uid: String) {
        
        Database.fetchUser(uid: uid) { (user) in
            self.fetchPostsFromDatabaseWith(user: user, onSuccess: {
                self.collectionView?.refreshControl?.endRefreshing()
                self.posts.sort(by: {$0.timestamp > $1.timestamp})
                print(self.posts.count)
                self.collectionView?.reloadData()
            })
        }
    }
    
    fileprivate func getFollowedUsers(uid: String, onSuccess: @escaping ([String: Any])-> Void) {
        Database.database().reference().child("following").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictonary = snapshot.value as? [String: Any] else {return}
            onSuccess(dictonary)
        }) { (err) in
            print(err, "failed fetching users")
            
        }
    }
    
    fileprivate func fetchPostsFromDatabaseWith(user: Profile, onSuccess: @escaping ()-> Void) {
        let userRef = Database.database().reference().child("posts").child(user.UID)
        
        userRef.queryOrdered(byChild: "creationDate").observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (values, key) in
            guard let dictonary = values.value as? [String: Any] else { return }
            dictonary.forEach({ (key, value) in
                guard let post = value as? [String: Any] else {return}
                print(key)
                self.posts.insert(Post(dictonary: post, user: user, key: key), at: 0)
            })
            onSuccess()
        }) { (err) in
            print(err)
        }
    }
    
    @objc func handleLiveCameraVC() {
        let cameraVC = FullCameraVC()
        present(cameraVC, animated: true, completion: nil)
    }
}
