//
//  URLImageView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/10/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

var imageCach = NSCache<NSString, UIImage>()

class MKImageView: UIImageView {
    
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
    
    fileprivate func downloadImage(url: URL) {
        lastURLUsedToLoadImage = url.absoluteString
        
        if let image = imageCach.object(forKey: url.absoluteString as NSString) {
            self.image = image
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print(err)
                print("couldn't download the image")
                return
            }
            
            if url.absoluteString != self.lastURLUsedToLoadImage {
                return
            }
            print("here")
            guard let data = data else { return }
            guard let imageValue = UIImage(data: data) else {return}
            imageCach.setObject(imageValue, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                self.image = imageValue
            }
        }.resume()
    }
}
