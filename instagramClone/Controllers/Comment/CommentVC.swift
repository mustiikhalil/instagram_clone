//
//  CommentVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/24/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

class CommentVC: UICollectionViewController {
    
    private var _post: Post?
    var post: Post? {
        set {
            _post = newValue
        }
        get {
            return _post
        }
    }
    
    var comments: [Comment] = []
    
    lazy var containerView: UIView = {
        let accessoryView = CommentInputAccessoryView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        accessoryView.delegate = self
        return accessoryView
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    fileprivate func fetchComments() {
        guard let postId = post?.key else {return}
        let ref = Database.database().reference().child("comments").child(postId)
        ref.observe(.childAdded, with: { (data) in
            guard let value = data.value as? [String: Any] else {return}
            guard let uid = value["userID"] as? String else {return}
            Database.fetchUser(uid: uid, onSuccess: { (profile) in
                let comment = Comment(dictionary: value, user: profile)
                self.comments.append(comment)
                self.collectionView.reloadData()
            })
            
        }) { (err) in
            print("failed to observe comments", err)
        }
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchComments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
}

//MARK:- UI
extension CommentVC: UICollectionViewDelegateFlowLayout {
    
    func setupUI() {
        navigationItem.title = "Comments"
        navigationController?.navigationBar.tintColor = .black
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: CellType.cell.ID)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let dummyCell = CommentCell(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        dummyCell.comment = comments[indexPath.item]
        dummyCell.layoutIfNeeded()
        let estimatedSize = dummyCell.systemLayoutSizeFitting(CGSize(width: view.frame.width, height: 1000))
        let height = max(40+8+8, estimatedSize.height)
        return CGSize(width: view.frame.width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.cell.ID, for: indexPath) as! CommentCell
        cell.comment = comments[indexPath.item]
        return cell
    }
    
}

extension CommentVC: CommentInputAccessoryProtocol {
    
    func saveCommentToDatabase(text commentText: String, onSuccess: @escaping ()->Void) {
        
        guard let postID = _post?.key else {return}
        guard let UID = Auth.auth().currentUser?.uid else {return}
        let profile = Profile(uid: UID, dictonary: [:])
        let comment = Comment(id: postID, comment: commentText, user: profile)
        Database.database().reference().child("comments").child(comment.id).childByAutoId().updateChildValues(comment.toDictonary) { (err, databaseRef) in
            if let err = err {
                print("faced error commenting ", err)
            }
            let index = IndexPath(item: self.comments.count-1, section: 0)
            self.collectionView.scrollToItem(at: index, at: .bottom, animated: true)
            onSuccess()
        }
        
    }
}
