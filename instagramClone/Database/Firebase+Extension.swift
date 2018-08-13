//
//  Firebase+Extension.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/13/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Firebase

extension Database {
    
    static func fetchUser(uid: String, onSuccess: @escaping (Profile) -> Void) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let dictonary = snapshot.value as? [String: Any] else { return }
            guard let value = dictonary as? [String : Any] else {return}
            let user = Profile(uid: uid, dictonary: value)
            onSuccess(user)
        }) { (err) in
            print(err)
        }
    }
}
