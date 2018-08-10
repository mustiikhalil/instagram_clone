//
//  Post.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/10/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Foundation

struct Post {
    let url: String
    let caption: String
    let dimensions: Dimensions
    let date = Date().timeIntervalSince1970
    
    func toDictonary() -> [String: Any] {
        return [
            "imageURL": url,
            "caption": caption,
            "creationData": date,
            "imageWidth": dimensions.width,
            "imageHeight": dimensions.height
        ]
    }
}
