//
//  SignUp+PickPhoto.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/29/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	
	//MARK:- Handles picking an image
	
	@objc func handleSelectingPhoto() {
		let imagePickerController = UIImagePickerController()
		imagePickerController.delegate = self
		imagePickerController.allowsEditing = true
		present(imagePickerController, animated: true, completion: nil)
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		
		if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
			plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
		} else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
			plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
		}
		setupImagePickerAfterUserPicking()
		
		dismiss(animated: true, completion: nil)
	}
	
}
