//
//  LoginVC+Firebase.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/1/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

extension LoginVC {
	
	@objc func handleLogin() {
		guard let email = emailTF.text else {return}
		guard let password = passwordTF.text else {return}
		
		Auth.auth().signIn(withEmail: email, password: password) { (authData, err) in
			
			if let err = err {
				print(err)
				print("err")
				return
			}
			
			print("success \(authData?.user.uid ?? "")")
			guard let mainTabBar = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarVC else { return }
			mainTabBar.setupViewControllers()
			
			self.dismiss(animated: true, completion: nil)
			
		}
	}
}
