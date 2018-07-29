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
		button.addTarget(self, action: #selector(handleSelectingPhoto), for: .touchUpInside)
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
		setupUI()
	}
	
}
