//
//  LoginVC+UI.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/1/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension LoginVC {
	
	func setupUI() {
		navigationController?.isNavigationBarHidden = true
		addSubviews()
		addAnchors()
		setupStackView()
	}
	
	fileprivate func addSubviews() {
		view.addSubview(dontHaveAccountButton)
		view.addSubview(logoContainerView)
	}
	
	fileprivate func addAnchors() {
		dontHaveAccountButton.anchor(leading: view.leadingAnchor, top: nil, trailing: view.trailingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 34)
		logoContainerView.anchor(leading: view.leadingAnchor, top: view.topAnchor, trailing: view.trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 150)
	}
		
	fileprivate func setupStackView() {
		let stackView = UIStackView(arrangedSubviews: [emailTF,passwordTF,loginButton])
		stackView.distribution = .fillEqually
		stackView.axis = .vertical
		stackView.spacing = 10
		view.addSubview(stackView)
		stackView.anchor(leading: view.leadingAnchor, top: logoContainerView.bottomAnchor, trailing: view.trailingAnchor, bottom: nil, paddingLeading: 40, paddingTop: 40, paddingTailing: 40, paddingBottom: 0, width: 0, height: 150)
		
	}
	
	@objc func handleTextInputChange() {
		let isFormValid = isValid()
		
		if isFormValid {
			loginButton.isEnabled = true
			loginButton.backgroundColor = .instagramBlue
			
		} else {
			loginButton.isEnabled = false
			loginButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
		}
	}
	
	func isValid() -> Bool {
		return emailTF.text?.isEmpty == false && passwordTF.text?.isEmpty == false && passwordTF.text?.count ?? 0 > 6
	}
}
