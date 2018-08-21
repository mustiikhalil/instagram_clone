//
//  ImageViewerVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/21/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class ImageViewerVC: UIViewController {
    
    let capturedImage: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        return iv
    }()
    
    var image: UIImage? {
        didSet {
            self.capturedImage.image = image
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
//        tabBarController?.tabBar.isHidden = true
    }
    
    
    func setupUI() {
        setupNavigationView()
        setupCapturedImageView()
        view.backgroundColor = .white
    }
    
    fileprivate func setupNavigationView() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleSharing))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDismissing))
    }
    
    fileprivate func setupCapturedImageView() {
        view.addSubview(capturedImage)
        capturedImage.anchor(leading: view.leadingAnchor, top: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
        capturedImage.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    @objc func handleDismissing() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func handleSharing() {
        let sharingVC = SharingVC()
        sharingVC.image = capturedImage.image
        navigationController?.pushViewController(sharingVC, animated: true)
    }
    
    
}

