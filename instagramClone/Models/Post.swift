//
//  Post.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/10/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

struct Post {
    
    private let _url: String
    private let _caption: String
    private let _dimensions: Dimensions
    private let _date: Double
    private var _image: UIImage?
    private let _user: Profile?
    
    var url: String {
        get { return _url }
    }
    
    var user: Profile? {
        get {
            return _user
        }
    }
    
    //gets the timestamp
    var timestamp: Double {
        get { return _date }
    }
    
    var caption: String {
        get {return _caption}
    }
    
    init(url: String, caption: String, dimensions: Dimensions, image: UIImage?, user: Profile? = nil) {
        _url = url
        _caption = caption
        _dimensions = dimensions
        _image = image
        _date = Date().timeIntervalSince1970
        _user = user
    }
    
    init(dictonary: [String: Any], user: Profile? = nil) {
        _user = user
        _url = dictonary["imageURL"] as? String ?? ""
        _caption = dictonary["caption"] as? String ?? ""
        _dimensions = Dimensions(width: dictonary["imageWidth"] as? CGFloat ?? 0.0, height: dictonary["imageHeight"] as? CGFloat ?? 0.0)
        _date = dictonary["creationDate"] as? Double ?? 0.0
    }
    
    func toDictonary() -> [String: Any] {
        return [
            "imageURL": _url,
            "caption": _caption,
            "creationDate": _date,
            "imageWidth": _dimensions.width,
            "imageHeight": _dimensions.height
        ]
    }
}
