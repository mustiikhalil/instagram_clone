//
//  CameraVC+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/20/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension CameraVC {
    
    func setupUI() {
        setupNavigationView()
        setupCameraView()
        setupCaptureButton()
        view.backgroundColor = .white
    }
    
    fileprivate func setupNavigationView() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleDismissing))
    }
    
    fileprivate func setupCameraView() {
        view.addSubview(cameraView)
        cameraView.anchor(leading: view.leadingAnchor, top: view.safeAreaLayoutGuide.topAnchor, trailing: view.trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
        cameraView.heightAnchor.constraint(equalTo: cameraView.widthAnchor).isActive = true
    }
    
    fileprivate func setupCaptureButton() {
        view.addSubview(captureButton)
        captureButton.anchorCenter(X: view.centerXAnchor, Y: nil, paddingX: 0, paddingY: 0, width: 0, height: 0)
        captureButton.anchor(leading: nil, top: nil, trailing: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 40, width: 80, height: 80)
    }
    
    @objc func handleDismissing() {
        dismiss(animated: true, completion: nil)
    }
}
