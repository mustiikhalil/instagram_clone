//
//  SearchCell.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/13/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit


class SearchCells: UICollectionViewCell {
    
    let userProfileImageView: MKImageView = {
        let iv = MKImageView()
        iv.layer.cornerRadius = 50/2
        iv.backgroundColor = .purple
        return iv
    }()
    
    let usernameLabel: MKLabel = {
        let label = MKLabel()
        label.text = "mustii"
        return label
    }()
    
    let numberOfposts: UILabel = {
        let label = UILabel()
        label.text = "2 posts"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func setupUI() {
        addSubview(userProfileImageView)
        userProfileImageView.anchor(leading: leadingAnchor, top: nil, trailing: nil, bottom: nil, paddingLeading: 8, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 50, height: 50)
        userProfileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [usernameLabel,numberOfposts])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(leading: userProfileImageView.trailingAnchor, top: topAnchor, trailing: nil, bottom: bottomAnchor, paddingLeading: 8, paddingTop: 8, paddingTailing: 0, paddingBottom: 8, width: 0, height: 0)
        
        let seperatorView = UIView()
        seperatorView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        addSubview(seperatorView)
        seperatorView.anchor(leading: usernameLabel.leadingAnchor, top: nil, trailing: trailingAnchor, bottom: bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
