//
//  ViewController.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/28/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

	let plusPhotoButton: UIButton = {
		let button = UIButton()
		button.setImage(#imageLiteral(resourceName: "plus_photo"), for: .normal)
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}()
	
	let emailTF: MKTextField = {
		return MKTextField(placeholder: "Email", color: UIColor(hexNumber: 0xF8F8F8))
	}()
	
	let userNameTF: MKTextField = {
		return MKTextField(placeholder: "Username", color: UIColor(hexNumber: 0xF8F8F8))
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		addSubviews()
		setConstraints()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	func addSubviews() {
		view.addSubview(plusPhotoButton)
		view.addSubview(emailTF)
		view.addSubview(userNameTF)
	}
	
	func setConstraints() {
		plusPhotoButton.heightAnchor.constraint(equalToConstant: 140).isActive = true
		plusPhotoButton.widthAnchor.constraint(equalToConstant: 140).isActive = true
		plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		plusPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
		setupInputFields()
	}
	
	fileprivate func setupInputFields() {
		let stackView = UIStackView(arrangedSubviews: [emailTF,userNameTF])
		stackView.setupLoginLayout()
		view.addSubview(stackView)
		stackView.topAnchor.constraint(equalTo: plusPhotoButton.bottomAnchor, constant: 20).isActive = true
		stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
		stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
		stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
	}

}
