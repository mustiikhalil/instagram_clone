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
                self.collectionView?.reloadData()
                self.collectionView.collectionViewLayout.invalidateLayout()
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
                guard let dictonary = value as? [String: Any] else {return}
                var post = Post(dictonary: dictonary, user: user, key: key)
                
                guard let uid = Auth.auth().currentUser?.uid else {return}
                Database.database().reference().child("likes").child(key).child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let hasLiked = snapshot.value as? Int, hasLiked == 1 {
                        post.isLiked = true
                    }
                    self.posts.insert(post, at: 0)
                    self.posts.sort(by: {$0.timestamp > $1.timestamp})
                    onSuccess()
                }, withCancel: { (err) in
                    print(err, "failed to fetch likes")
                })
            })
        }) { (err) in
            print(err)
        }
    }
    
    @objc func handleLiveCameraVC() {
        let cameraVC = FullCameraVC()
        present(cameraVC, animated: true, completion: nil)
    }
}

extension HomeVC: HomePostCellDelegate {
    
    
    func didTapHearts(with Cell: HomeCell) {
        guard let indexPath = collectionView?.indexPath(for: Cell) else {return}
        var post = posts[indexPath.item]
        guard let postID = post.key else {return}
        guard let UID = Auth.auth().currentUser?.uid else {return}
        
        let dictonary = [UID: post.isLiked ? 0 : 1]
        Database.database().reference().child("likes").child(postID).updateChildValues(dictonary) { (err, database) in
            if let err = err {
                print("Err liking posts: ", err)
            }
            post.isLiked = !post.isLiked
            self.posts[indexPath.item] = post
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
    
    func didTapComment(withPost post: Post) {
        guard let navController = navigationController else {return}
        let commentVC = CommentVC(collectionViewLayout: UICollectionViewFlowLayout())
        commentVC.post = post
        navController.pushViewController(commentVC, animated: true)
    }
    
    func didTapUsername(withPost: Post) {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        guard let navController = navigationController else {return}
        let profileVC = UserProfileVC(collectionViewLayout: UICollectionViewFlowLayout())
        profileVC.userId = withPost.user?.UID
        navController.pushViewController(profileVC, animated: true)
    }
}
