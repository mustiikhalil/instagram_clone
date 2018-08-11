//
//  HomeCells.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/11/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class HomeCell: UICollectionViewCell {
    
    var post: Post? {
        didSet{
            guard let post = post else { return }
            setupViewAfterNetworkCall(post: post)
        }
    }
    
    let imageView: MKImageView = {
        let iv = MKImageView()
        iv.backgroundColor = .red
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(imageView)
        imageView.anchor(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
        imageView.backgroundColor = .purple
    }
    
    fileprivate func setupViewAfterNetworkCall(post: Post) {
        imageView.loadImage(url: post.url)
    }
}
