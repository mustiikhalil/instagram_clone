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
        downloadImage(url: imageURL)
    }
    
    fileprivate func downloadImage(url imageURL: URL) {
        lastURLUsedToLoadImage = imageURL.absoluteString
        if let image = imageCache.object(forKey: imageURL.absoluteString as NSString) {
            print("getting from cache")
            self.image = image
            return
        }
        URLSession.shared.dataTask(with: imageURL) { (data, urlResponse, err) in
            
            if let err = err {
                print("Couldn't fetch the images", err)
                return
            }
            
            if imageURL.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            guard let imageData = data else {return}
            guard let image = UIImage(data: imageData) else {return}
            imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
            print("downloading image")
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
