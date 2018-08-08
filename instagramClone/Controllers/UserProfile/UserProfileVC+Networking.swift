//
//  UserProfileVC+Networking.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/2/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

extension UserProfileVC {
    
    func fetchUser() {
        fetchUserFromDatabase { (dictonary) in
            self.fetchProfileImageForUser(dictonary: dictonary, onSuccess: { (profile) in
                self.profile = profile
            })
        }
    }
    
    fileprivate func fetchUserFromDatabase(onSuccess: @escaping ([String: Any])-> Void ) {
        
        guard let UID = Auth.auth().currentUser?.uid else { return }
        Database.database().reference().child("users").child(UID).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictonary = snapshot.value as? [String: Any] else { return }
            onSuccess(dictonary)
        }) { (err) in
            print(err)
        }
    }
    
    fileprivate func fetchProfileImageForUser(dictonary: [String: Any], onSuccess: @escaping (Profile)-> Void ) {
        
        guard let userUrl = dictonary["profileLink"] as? String else {return}
        guard let url = URL(string: userUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, urlResponse, err) in
            
            if let err = err {
                print(err)
                print("problem fetching data")
                return
            }
            
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                let profile = Profile(dictonary: dictonary, imageData: data)
                onSuccess(profile)
            }
        }.resume()
    }
    
}
