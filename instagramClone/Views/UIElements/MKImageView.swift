//
//  URLImageView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/10/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

var imageCache = NSCache<NSString, UIImage>()
let operationQueue: OperationQueue = {
    let op = OperationQueue()
    op.name = "downloading"
    return op
}()

class MKImageView: UIImageView {
    static var number = 1
    var lastURLUsedToLoadImage: String?
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(url: String) {
        guard let imageURL = URL(string: url) else { return }
        if let image = imageCache.object(forKey: imageURL.absoluteString as NSString) {
            print("getting from cache")
            self.image = image
            return
        }
        DispatchQueue.global(qos: .background).async {
            if imageURL.absoluteString  == self.lastURLUsedToLoadImage {
                return
            }
            guard let data = try? Data(contentsOf: imageURL) else {return}
            let img = UIImage(data: data)
            guard let image = img else {return}
            print("downloading data")
            imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
            DispatchQueue.main.async {
                self.image = img
            }
        }
    }
}
