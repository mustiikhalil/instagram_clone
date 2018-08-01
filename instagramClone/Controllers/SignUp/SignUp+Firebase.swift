//
//  SignUp+Firebase.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/29/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

extension SignUpVC {
	
	// MARK:- Firebase
	@objc func handleSignUp() {
		signUp()
	}
	
	// Sign up function
	private func signUp() {
		guard let username = userNameTF.text, username.count != 0  else {return}
		guard let email = emailTF.text, email.count != 0 else {return}
		guard let password = passwordTF.text, password.count != 0  else {return}
		
		// Creates the auth of the user and adds him to Auth database
		Auth.auth().createUser(withEmail: email, password: password) { (authResult , error) in
			
			if let err = error {
				print(err)
				return
			}
			// uploads the user profile picture
			
			self.uploadProfileImage(onSuccess: { (url) in
				if let user = authResult?.user {
					
					// Saves user to database
					
					self.createUser(user, withProfilePicture: url)
				}
			}, onFailure: {
				print("Fail")
			})
		}
	}
	
	// Validation for the fields needed
	func isValid() -> Bool {
		return emailTF.text?.isEmpty == false && userNameTF.text?.isEmpty == false && passwordTF.text?.isEmpty == false && passwordTF.text?.count ?? 0 > 6
	}
	
	//MARK:- Uploading the user image
	func uploadProfileImage(onSuccess: @escaping (String)->Void, onFailure: @escaping ()-> Void) {
		
		guard let image = self.plusPhotoButton.imageView?.image else {
			return
		}
		guard let uploadData = UIImageJPEGRepresentation(image, 0.3) else {return}

		let storageRef = Storage.storage().reference()
		let upload = storageRef.child("profile_images").child(NSUUID().uuidString)
		
		upload.putData(uploadData, metadata: nil, completion: { (metadata, err) in
			
			guard let data = metadata else {
				onFailure()
				return
			}
			upload.downloadURL(completion: { (url, err) in
				guard let downloadURL = url else {
					onFailure()
					return
				}
				onSuccess(downloadURL.absoluteString)

			})
		})
	}
	
	// MARK:- Creating User after uploading the image
	
	func createUser(_ user: User, withProfilePicture url: String){
		let data = ["username": userNameTF.text!,"profileLink": url]
		let value = [user.uid: data]
		
		Database.database().reference().child("users").updateChildValues(value) { (err, dataRef) in
			if let err = err {
				print(err)
				return
			}
			
			guard let mainTabBar = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarVC else {return}
			mainTabBar.setupViewControllers()
			self.dismiss(animated: true, completion: nil)
		}
	}

}
