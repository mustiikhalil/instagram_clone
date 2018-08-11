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
        setupUI(withID: .cellID)
        fetchPosts()
    }
    
    func fetchPosts() {
        fetchUserPostsFromDatabase { (posts) in
            self.posts = posts
            self.collectionView?.reloadData()
        }
    }
    
    func fetchUserPostsFromDatabase(onSuccess: @escaping ([Post])-> Void) {
        guard let UID = Auth.auth().currentUser?.uid else { return }
        let userRef = Database.database().reference().child("posts").child(UID)
        
        userRef.observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (values, key) in
            guard let dictonary = values.value as? [String: Any] else { return }
            let postsValue = dictonary.map({ (arg) -> Post in
                let (_, value) = arg
                return Post(dictonary: value as! [String : Any])
            })
            onSuccess(postsValue)
        }) { (err) in
            print(err)
        }
    }
    
    func setupUI(withID id: CellType) {
        collectionView?.backgroundColor = .white
        collectionView?.register(HomeCell.self, forCellWithReuseIdentifier: id.rawValue)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo2"))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.cellID.rawValue, for: indexPath) as! HomeCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 300)
    }
    
}
