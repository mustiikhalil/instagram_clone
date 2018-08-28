//
//  HomeCells.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/11/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

protocol HomePostCellDelegate {
    func didTapComment(withPost: Post)
    func didTapUsername(withPost: Post)
    func didTapHearts(with Cell: HomeCell)
}

class HomeCell: UICollectionViewCell {
    
    var post: Post? {
        didSet{
            guard let post = post else { return }
            setupViewAfterNetworkCall(post: post)
        }
    }
    
    var delegate: HomePostCellDelegate?
    
    let userProfileImageView: MKImageView = {
        let iv = MKImageView()
        iv.layer.cornerRadius = 40 / 2
        return iv
    }()
    
    let usernameLabel: MKLabel = {
        let label = MKLabel()
        label.setupLabelForHomeViewWith(username: "Mustii welcome home")
        return label
    }()
    
    let imageView: MKImageView = {
        let iv = MKImageView()
        return iv
    }()
    
    let optionsButton: MKButton = {
        let mk = MKButton()
        mk.setupMainViewButtons(type: .options)
        return mk
    }()
    
    lazy var commentButton: MKButton = {
        let mk = MKButton()
        mk.setupMainViewButtons(type: .comment)
        mk.addTarget(self, action: #selector(handleComment), for: .touchUpInside)
        return mk
    }()
    
    let shareButton: MKButton = {
        let mk = MKButton()
        mk.setupMainViewButtons(type: .share)
        return mk
    }()
    
    let ribbonButton: MKButton = {
        let mk = MKButton()
        mk.setupMainViewButtons(type: .ribbon)
        return mk
    }()
    
    lazy var heartsButton: MKButton = {
        let mk = MKButton()
        mk.setupMainViewButtons(type: .heart)
        mk.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        return mk
    }()
    
    let bookmarkButton: MKButton = {
        let mk = MKButton()
        mk.setupMainViewButtons(type: .ribbon)
        return mk
    }()
    let captionLabel: UITextView = {
        let txt = UITextView()
        txt.allowsEditingTextAttributes = false
        txt.isScrollEnabled = false
        return txt
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTap()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    fileprivate func setupViewAfterNetworkCall(post: Post) {
        guard let user = post.user else {return}
        userProfileImageView.loadImage(url: user.profileURL)
        imageView.loadImage(url: post.url)
        usernameLabel.text = user.username
        heartsButton.setImage(post.isLiked == false ? #imageLiteral(resourceName: "like_unselected").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "like_selected").withRenderingMode(.alwaysOriginal), for: .normal)
        setupLabelForHomeViewWith(caption: post.caption, username: user.username, time: post.timestamp)
    }
    
    func setupLabelForHomeViewWith(caption: String, username: String, time: Double) {
        let customText = NSMutableAttributedString(string: "\(username) ", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
        
        customText.append(NSAttributedString(string: caption, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        
        customText.append(NSAttributedString(string: "\n\n", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 4)]))
        
        customText.append(NSAttributedString(string: "\(Date(timeIntervalSince1970: time).timeAgoDisplay())", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.gray]))
        captionLabel.attributedText = customText
    }
    
    fileprivate func setupTap() {
        let usernameTap = UITapGestureRecognizer(target: self, action: #selector(handleUsernameTapped))
        usernameLabel.addGestureRecognizer(usernameTap)
        usernameLabel.isUserInteractionEnabled = true
    }
    
    @objc func handleLike() {
        delegate?.didTapHearts(with: self)
    }
    
    @objc private func handleComment() {
        guard let post = post else {return}
        delegate?.didTapComment(withPost: post)
    }
    
    @objc private func handleUsernameTapped() {
        guard let post = post else {return}
        delegate?.didTapUsername(withPost: post)
    }
}
