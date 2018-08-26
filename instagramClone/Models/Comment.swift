//
//  Comment.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/24/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Foundation

struct Comment {
    let id: String
    let comment: String
    let user: Profile
    let date: Double
    
    init(id: String, comment: String, user: Profile) {
        self.id = id
        self.comment = comment
        self.user = user
        date = Date().timeIntervalSince1970
    }
    
    init(dictionary: [String: Any], user: Profile) {
        id = dictionary["postID"] as? String ?? ""
        comment = dictionary["comment"] as? String ?? ""
        self.user = user
        date = dictionary["date"] as? Double ?? 0.0
    }
    var toDictonary: [String: Any] {
        get {
            return [
                "postID": id,
                "comment": comment,
                "userID": user.UID,
                "date": date
            ]
        }
    }
}
