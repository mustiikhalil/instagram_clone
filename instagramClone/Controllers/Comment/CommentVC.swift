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
        guard let post = _post else {return}
        guard let postID = _post?.key else {return}
        guard let UID = Auth.auth().currentUser?.uid else {return}
        let comment = Comment(id: postID, comment: commentText, user: UID)
        Database.database().reference().child("comments").child(comment.id).childByAutoId().updateChildValues(comment.toDictonary) { (err, databaseRef) in
            if let err = err {
                print("faced error commenting ", err)
            }
            print("wonderful <3")
        }
    }
    
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Comments"
        collectionView.backgroundColor = .red
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

struct Comment {
    let id: String
    let comment: String
    let user: String
    let date = Date().timeIntervalSince1970
    var toDictonary: [String: Any] {
        get {
            return [
                "postID": id,
                "comment": comment,
                "userID": user,
                "date": date
            ]
        }
    }
}
