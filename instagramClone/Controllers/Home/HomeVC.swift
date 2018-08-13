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
                self.posts.insert(Post(dictonary: post, user: user), at: 0)
            })
            onSuccess()
        }) { (err) in
            print(err)
        }
    }

    func setupUI(withID cell: CellType) {
        collectionView?.backgroundColor = .white
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: cell.ID)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.cell.ID, for: indexPath) as! HomeCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 40 + 16 // username and profile image view
        height += view.frame.width + 50 + 60
        return CGSize(width: collectionView.frame.width, height: height)
    }
}
