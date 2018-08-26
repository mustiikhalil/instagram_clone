//
//  PostViewVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/26/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class PostViewVC: UIViewController {
    
    var profile: Profile? {
        didSet {
            guard let user = profile else { return }
            userImage.loadImage(url: user.profileURL)
            usernameLabel.text = user.username
        }
    }
    
    var post: Post? {
        didSet {
            guard let post = post else { return }
            imageView.loadImage(url: post.url)
        }
    }
    
    let imageView: MKImageView = {
        let iv = MKImageView()
        return iv
    }()
    let userImage: MKImageView = {
        let iv = MKImageView()
        return iv
    }()
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    func setupUI() {
        view.backgroundColor = .white
        navigationItem.title = "Photo"
        navigationController?.navigationBar.tintColor = .black
        view.addSubview(userImage)
        view.addSubview(usernameLabel)
        view.addSubview(imageView)
        
        userImage.anchor(leading: view.leadingAnchor, top: view.safeAreaLayoutGuide.topAnchor, trailing: nil, bottom: nil, paddingLeading: 8, paddingTop: 8, paddingTailing: 0, paddingBottom: 0, width: 40, height: 40)
        userImage.layer.cornerRadius = 40/2
        
        usernameLabel.anchor(leading: userImage.trailingAnchor, top: userImage.topAnchor, trailing: view.trailingAnchor, bottom: nil, paddingLeading: 8, paddingTop: 4, paddingTailing: 20, paddingBottom: 0, width: 0, height: 0)
        imageView.anchor(leading: view.leadingAnchor, top: userImage.bottomAnchor, trailing: view.trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 8, paddingTailing: 0, paddingBottom: 0, width: 0, height: view.frame.width - 50)
    }
}
