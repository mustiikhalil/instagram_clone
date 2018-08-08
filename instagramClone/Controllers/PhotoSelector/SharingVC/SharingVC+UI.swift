//
//  SharingVC+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/8/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension SharingVC {
    
    func setupUI() {
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        setupNavBar()
        setupImageAndTextField()
    }
    
    fileprivate func setupImageAndTextField() {
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(leading: view.leadingAnchor, top: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(leading: containerView.leadingAnchor, top: containerView.topAnchor, trailing: nil, bottom: containerView.bottomAnchor, paddingLeading: 8, paddingTop: 8, paddingTailing: 0, paddingBottom: 8, width: 84, height: 0)
        containerView.addSubview(textView)
        textView.anchor(leading: imageView.trailingAnchor, top: containerView.topAnchor, trailing: containerView.trailingAnchor, bottom: containerView.bottomAnchor, paddingLeading: 4, paddingTop: 8, paddingTailing: 8, paddingBottom: 8, width: 0, height: 0)
    }
    
    fileprivate func setupNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(handleSharing))
        navigationController?.navigationBar.tintColor = .black
    }
}
