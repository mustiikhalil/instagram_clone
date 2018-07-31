//
//  SignUp+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/29/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension SignUpVC {
	
	// MARK:- Setting up UI & Constraints
	
	func setupUI() {
		setConstraintsAndAddSubViews()
	}
	
	fileprivate func setConstraintsAndAddSubViews() {
		view.addSubview(plusPhotoButton)
		plusPhotoButton.anchor(leading: nil, top: view.safeAreaLayoutGuide.topAnchor, trailing: nil, bottom: nil, paddingLeading: 0, paddingTop: 40, paddingTailing: 0, paddingBottom: 0, width: 140, height: 140)
		plusPhotoButton.anchorCenter(X: view.centerXAnchor, Y: nil, paddingX: 0, paddingY: 0, width: 0, height: 0)
		setupInputFields()
	}
	
	fileprivate func setupInputFields() {
		let stackView = UIStackView(arrangedSubviews: [emailTF,userNameTF,passwordTF,signUpButton])
		stackView.distribution = .fillEqually
		stackView.axis = .vertical
		stackView.spacing = 10
		view.addSubview(stackView)
		stackView.anchor(leading: view.leadingAnchor, top: plusPhotoButton.bottomAnchor, trailing: view.trailingAnchor, bottom: nil, paddingLeading: 40, paddingTop: 20, paddingTailing: 40, paddingBottom: 0, width: 0, height: 200)
	}
	
	// Checks if the form is valid and enables and colors the button
	
	@objc func handleTextInputChange() {
		let isFormValid = isValid()
		
		if isFormValid {
			signUpButton.isEnabled = true
			signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 164, blue: 237)
			
		} else {
			signUpButton.isEnabled = false
			signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
		}
	}
	
	func setupImagePickerAfterUserPicking()  {
		plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
		plusPhotoButton.layer.masksToBounds = true
		plusPhotoButton.layer.borderColor = UIColor.black.cgColor
		plusPhotoButton.layer.borderWidth = 2
		plusPhotoButton.imageView?.contentMode = .scaleAspectFill
	}
}
