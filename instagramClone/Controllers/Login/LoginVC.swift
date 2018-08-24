//
//  LoginVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/1/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
	
	let dontHaveAccountButton: UIButton = {
		let button = UIButton(type: .system)
		let attruibutedText = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)])
		attruibutedText.append(NSAttributedString(string: "Sign Up.", attributes: [NSAttributedString.Key.foregroundColor: UIColor.rgb(red: 17, green: 164, blue: 237), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]))
		
		button.setAttributedTitle(attruibutedText, for: .normal)
		button.addTarget(self, action: #selector(handleTransitionToSignUpVC), for: .touchUpInside)
		return button
	}()
	
	let emailTF: MKTextField = {
		let TF = MKTextField(placeholder: .Email, color: UIColor.rgb(red: 248, green: 248, blue: 248), keyboardType: .emailAddress)
		TF.autocorrectionType = .no
		TF.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
		return TF
	}()
	
	let passwordTF: MKTextField = {
		let TF = MKTextField(placeholder: .Password, color: UIColor.rgb(red: 248, green: 248, blue: 248), keyboardType: .default)
		TF.isSecureTextEntry = true
		TF.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
		return TF
	}()
	
	let loginButton: MKButton = {
		let button = MKButton()
        button.setUpLoginAndSignUPButtons(title: .login, titleColor: .white, backgroundColor: UIColor.rgb(red: 149, green: 204, blue: 244), raduis: 5)
		button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
		return button
	}()
	
	let logoContainerView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor.rgb(red: 0, green: 120, blue: 175)
		
		let logo: UIImageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white").withRenderingMode(.alwaysOriginal))
		view.addSubview(logo)
		logo.contentMode = .scaleAspectFill
		logo.anchor(leading: nil, top: nil, trailing: nil, bottom: nil, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 200, height: 50)
		logo.anchorCenter(X: view.centerXAnchor, Y: view.centerYAnchor, paddingX: 0, paddingY: 0, width: 200, height: 50)
		return view
	}()
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		setupUI()
	}
	
	@objc fileprivate func handleTransitionToSignUpVC() {
		
		navigationController?.pushViewController(SignUpVC(), animated: true)
	}
}
