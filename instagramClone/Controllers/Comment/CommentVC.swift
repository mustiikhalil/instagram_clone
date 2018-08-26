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
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
       
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Post", for: .normal)
        sendButton.setTitleColor(.black, for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        sendButton.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        
        containerView.addSubview(sendButton)
        containerView.addSubview(commentTextField)
        sendButton.anchor(leading: nil, top: containerView.topAnchor, trailing: containerView.trailingAnchor, bottom: containerView.bottomAnchor, paddingLeading: 12, paddingTop: 0, paddingTailing: 12, paddingBottom: 0, width: 50, height: 0)
        commentTextField.anchor(leading: containerView.leadingAnchor, top: containerView.topAnchor, trailing: sendButton.leadingAnchor, bottom: containerView.bottomAnchor, paddingLeading: 12, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
        
        let lineSeparator = UIView()
        lineSeparator.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        containerView.addSubview(lineSeparator)
        lineSeparator.anchor(leading: containerView.leadingAnchor, top: containerView.topAnchor, trailing: containerView.trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0.5)
        
        return containerView
    }()
    
    let commentTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Enter comment..."
        return tf
    }()
    
    override var inputAccessoryView: UIView? {
        get {
            return containerView
        }
    }
    
    @objc func handleComment() {
        guard let commentText = commentTextField.text, !commentText.isEmpty else { return }
        guard let postID = _post?.key else {return}
        guard let UID = Auth.auth().currentUser?.uid else {return}
        let profile = Profile(uid: UID, dictonary: [:])
        let comment = Comment(id: postID, comment: commentText, user: profile)
        Database.database().reference().child("comments").child(comment.id).childByAutoId().updateChildValues(comment.toDictonary) { (err, databaseRef) in
            if let err = err {
                print("faced error commenting ", err)
            }
            print("wonderful <3")
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
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: -50, right: 0)
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
