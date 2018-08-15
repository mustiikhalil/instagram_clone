//
//  ImageDownloader.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/15/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class ImageDownloader: Operation {
    
    private let url: URL
    
    init(withURL: URL) {
        url = withURL
        super.init()
    }
    
    func main(lastURL: String?, onSccuess: @escaping (UIImage)->Void){
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            print("getting from cache")
            onSccuess(image)
            return
        }
        
        if url.absoluteString != lastURL {
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {return}
        let img = UIImage(data: data)
        guard let image = img else {return}
        print("downloading data")
        imageCache.setObject(image, forKey: url.absoluteString as NSString)
        onSccuess(image)
    }
}

