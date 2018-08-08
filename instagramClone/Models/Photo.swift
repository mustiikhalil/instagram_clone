//
//  Photo.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/8/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import Photos

struct Photo: Equatable {
    
    private let _asset: PHAsset
    private let _lowResImage: UIImage
    private var _highResImage: UIImage?
    
    var asset: PHAsset {
        get { return _asset }
    }
    var lowResImage: UIImage {
        get { return _lowResImage }
    }
    
    var highResImage: UIImage? {
        get { return self._highResImage }
        set { self._highResImage = newValue}
    }
    
    init(image: UIImage, asset: PHAsset, highResImage hrImage: UIImage? = nil) {
        self._asset = asset
        self._lowResImage = image
        self._highResImage = hrImage
    }
    
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs._asset == rhs._asset && lhs._lowResImage == rhs._lowResImage && lhs._highResImage == rhs._highResImage
    }
}
