//
//  ViewController.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/28/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

class SignUpVC: UIViewController {

	let plusPhotoButton: UIButton = {
		let button = UIButton()
		button.setImage(#imageLiteral(resourceName: "plus_photo").withRenderingMode(.alwaysOriginal), for: .normal)
		return button
	}()
	
	let emailTF: MKTextField = {
		let tf = MKTextField(placeholder: .Email, color: UIColor.rgb(red: 248, green: 248, blue: 248), keyboardType: .emailAddress)
		tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
		return tf
	}()
	
	let userNameTF: MKTextField = {
		let tf = MKTextField(placeholder: .Username, color: UIColor.rgb(red: 248, green: 248, blue: 248))
		tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
		return tf
	}()
	
	let passwordTF: MKTextField = {
		let tf = MKTextField(placeholder: .Password, color: UIColor.rgb(red: 248, green: 248, blue: 248))
		tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
		tf.isSecureTextEntry = true
		return tf
	}()
	
	let signUpButton: UIButton = {
		let button = MKButton(title: .signup, titleColor: .white, backgroundColor: UIColor.rgb(red: 149, green: 204, blue: 244), raduis: 5)
		button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
		button.isEnabled = false
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
	
	@objc fileprivate func handleSignUp() {
		guard let username = userNameTF.text, username.count != 0  else {return}
		guard let email = emailTF.text, email.count != 0 else {return}
		guard let password = passwordTF.text, password.count != 0  else {return}
		
		Auth.auth().createUser(withEmail: email, password: password) { (authResult , error) in
			
			if let err = error {
				print(err)
				return
			}
			
			print("\(authResult?.user.uid) is the UID of the current sign up")
			
		}
	}
	
	@objc fileprivate func handleTextInputChange() {
		let isFormValid = isValid()
		signUpButton.isEnabled = isFormValid
	
		if isFormValid {
			signUpButton.backgroundColor = UIColor.rgb(red: 17, green: 164, blue: 237)

		} else {
			signUpButton.backgroundColor = UIColor.rgb(red: 149, green: 204, blue: 244)
		}
	}
	
	func isValid() -> Bool {
		return emailTF.text?.isEmpty == false && userNameTF.text?.isEmpty == false && passwordTF.text?.isEmpty == false && passwordTF.text?.count ?? 0 > 6
	}

}

