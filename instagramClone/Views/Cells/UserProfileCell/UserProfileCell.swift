//
//  UserProfileCell.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/10/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

protocol PostViewWillAppear {
    func pushToPostView(post: Post)
}

class UserProfileCell: UICollectionViewCell {
    
    let imageView = MKImageView()

    var post: Post? {
        didSet {
            guard let imageURL = post?.url else { return }
            self.imageView.loadImage(url: imageURL)
        }
    }
    var delegate: PostViewWillAppear?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(imageView)
        imageView.anchor(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    @objc func didTap() {
        guard let post = post else {return }
        delegate?.pushToPostView(post: post)
    }
}
