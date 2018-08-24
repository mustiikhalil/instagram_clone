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
    
    let heartsButton: MKButton = {
        let mk = MKButton()
        mk.setupMainViewButtons(type: .heart)
        return mk
    }()
    
    let bookmarkButton: MKButton = {
        let mk = MKButton()
        mk.setupMainViewButtons(type: .ribbon)
        return mk
    }()
    let captionLabel = MKLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    fileprivate func setupViewAfterNetworkCall(post: Post) {
        guard let user = post.user else {return}
        userProfileImageView.loadImage(url: user.profileURL)
        imageView.loadImage(url: post.url)
        usernameLabel.text = user.username
        captionLabel.setupLabelForHomeViewWith(caption: post.caption, username: user.username, time: post.timestamp)
    }
    
    @objc private func handleComment() {
        guard let post = post else {return}
        delegate?.didTapComment(withPost: post)
    }
}
