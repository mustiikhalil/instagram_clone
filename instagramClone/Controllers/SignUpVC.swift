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
		button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
		return button
	}()
	
	let emailTF: MKTextField = {
		let tf = MKTextField(placeholder: "Email", color: UIColor.rgb(red: 248, green: 248, blue: 248), keyboardType: .emailAddress)
		return tf
	}()
	
	let userNameTF: MKTextField = {
		return MKTextField(placeholder: "Username", color: UIColor.rgb(red: 248, green: 248, blue: 248))
	}()
	
	let passwordTF: MKTextField = {
		let tf = MKTextField(placeholder: "Username", color: UIColor.rgb(red: 248, green: 248, blue: 248))
		tf.isSecureTextEntry = true
		return tf
	}()
	
	let signUpButton: UIButton = {
		let button = MKButton(title: .signup, titleColor: .white, backgroundColor: UIColor.rgb(red: 149, green: 204, blue: 244), raduis: 5)
		return button
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setConstraintsAndAddSubViews()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	fileprivate func setConstraintsAndAddSubViews() {
		view.addSubview(plusPhotoButton)
		plusPhotoButton.anchor(leading: nil, top: view.safeAreaLayoutGuide.topAnchor, trailing: nil, bottom: nil, paddingLeft: 0, paddingTop: 40, paddingRight: 0, paddingBottom: 0, height: 140, width: 140)
		plusPhotoButton.anchorCenter(X: view.centerXAnchor, Y: nil, paddingX: 0, paddingY: 0)
		setupInputFields()
	}
	
	fileprivate func setupInputFields() {
		let stackView = UIStackView(arrangedSubviews: [emailTF,userNameTF,passwordTF,signUpButton])
		stackView.distribution = .fillEqually
		stackView.axis = .vertical
		stackView.spacing = 10
		view.addSubview(stackView)
		stackView.anchor(leading: view.leadingAnchor, top: plusPhotoButton.bottomAnchor, trailing: view.trailingAnchor, bottom: nil, paddingLeft: 40, paddingTop: 20, paddingRight: 40, paddingBottom: 0, height: 200, width: 0)
	}

}

