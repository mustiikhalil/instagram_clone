//
//  FullCameraVC+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/20/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension FullCameraVC {
    
    func setupUI() {
        view.backgroundColor = .black
        setupButtons()
    }
    
    fileprivate func setupButtons() {
        view.addSubview(captureButton)
        view.addSubview(backButton)
        captureButton.anchorCenter(X: view.centerXAnchor, Y: nil, paddingX: 0, paddingY: 0, width: 0, height: 0)
        captureButton.anchor(leading: nil, top: nil, trailing: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 40, width: 80, height: 80)
        backButton.anchor(leading: nil, top: view.topAnchor, trailing: view.trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 30, paddingTailing: 4, paddingBottom: 0, width: 40, height: 40)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return slidingAnimation
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return slidingAnimation
    }
    
}
