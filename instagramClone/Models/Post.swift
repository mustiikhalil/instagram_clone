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
    
    var url: String {
        get { return _url }
    }
    
    init(url: String, caption: String, dimensions: Dimensions, image: UIImage?) {
        _url = url
        _caption = caption
        _dimensions = dimensions
        _image = image
        _date = Date().timeIntervalSince1970
    }
    
    init(dictonary: [String: Any]) {
        _url = dictonary["imageURL"] as? String ?? ""
        _caption = dictonary["caption"] as? String ?? ""
        _dimensions = Dimensions(width: dictonary["imageWidth"] as? CGFloat ?? 0.0, height: dictonary["imageHeight"] as? CGFloat ?? 0.0)
        _date = dictonary["caption"] as? Double ?? 0.0
    }
    
    func toDictonary() -> [String: Any] {
        return [
            "imageURL": _url,
            "caption": _caption,
            "creationData": _date,
            "imageWidth": _dimensions.width,
            "imageHeight": _dimensions.height
        ]
    }
    
    mutating func setImage(image: UIImage) {
        self._image = image
    }
}
