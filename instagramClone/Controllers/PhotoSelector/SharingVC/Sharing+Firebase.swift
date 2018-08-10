//
//  File.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/10/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Firebase

extension SharingVC {
    
    @objc func handleSharing() {
        
        guard let UID = Auth.auth().currentUser?.uid else {return}
        
        let caption = textView.text ?? ""
        guard let image = imageView.image else { return }
        let imageData = UIImageJPEGRepresentation(image, 0.5)
        guard let data = imageData else { return }
        let dimensions = Dimensions(width: image.size.width, height: image.size.height)
        let filename = NSUUID().uuidString
        
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    
        sharingStarted(withUID: UID, withCaption: caption, withFilename: filename, imageDimensions: dimensions, withData: data)
    }
    
    fileprivate func sharingStarted(withUID UID: String, withCaption caption: String, withFilename filename: String, imageDimensions: Dimensions , withData data: Data) {
        
        handleUploadingImage(withFilename: filename, image: data) { (url) in
            let post = Post(url: url, caption: caption, dimensions: imageDimensions)
            self.handleSavingPostToDatabase(withUID: UID, withPost: post) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    fileprivate func handleUploadingImage(withFilename: String, image: Data, onSuccess: @escaping (String) -> Void) {
        
        let storageReference =  Storage.storage().reference().child("Shared").child(withFilename)
        storageReference.putData(image, metadata: nil) { (data, err) in
            
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print(err)
                print("Failed")
                return
            }
            storageReference.downloadURL(completion: { (url, err) in
                
                if let err = err {
                    self.navigationItem.rightBarButtonItem?.isEnabled = true
                    print(err)
                    print("Failed Fetching URL")
                    return
                }
                guard let stringURL = url?.absoluteString else {return}
                onSuccess(stringURL)
            })
        }
    }
    
    fileprivate func handleSavingPostToDatabase(withUID uid: String, withPost post: Post, onSuccess: @escaping () -> Void) {
        let userRef = Database.database().reference().child("posts").child(uid)
        let ref = userRef.childByAutoId()
        
        ref.updateChildValues(post.toDictonary()) { (err, ref) in
            if let err = err {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                print("err saving to database", err)
                return
            }
            onSuccess()
        }
    }
}
