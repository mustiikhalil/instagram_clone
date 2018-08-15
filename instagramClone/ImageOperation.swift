//
//  ImageOperation.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/15/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

var imagePendingQueue: OperationQueue = {
    let iq = OperationQueue()
    iq.maxConcurrentOperationCount = 1
    iq.name = "imageDownloader"
    return iq
}()

class ImageDownloader: Operation {
    
    let url: URL
    let lastURL: String
    private var _image: UIImage?
    
    var image: UIImage? {
        get { return _image}
    }
    
    init(withURL: URL) {
        url = withURL
        lastURL = withURL.absoluteString
    }
    
    func main(url lastURL: String?) {
        
        if self.lastURL != lastURL {
            return
        }
        
        if isCancelled {
            return
        }
        
        print("downloading")
        guard let img = try? Data(contentsOf: url) else { return }
        
        if isCancelled {
            return
        }
        
        if !img.isEmpty {
            _image = UIImage(data: img)
        }
    }
}

class UIRefresher: Operation {
    
    init(imageDownloader: ImageDownloader) {
        super.init()
        addDependency(imageDownloader)
    }
    
    func main(onSccuess: @escaping () -> Void) {
        DispatchQueue.main.async {
            onSccuess()
        }
    }
}
