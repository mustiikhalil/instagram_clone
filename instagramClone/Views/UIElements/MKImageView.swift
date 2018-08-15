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
        lastURLUsedToLoadImage = imageURL.absoluteString
        let imgDownloader = ImageDownloader(withURL: imageURL)
        operationQueue.addOperation {
            imgDownloader.main(lastURL: self.lastURLUsedToLoadImage) {
                DispatchQueue.main.async {
                    self.image = imgDownloader.image
                }
            }
        }
    }
}

class ImageDownloader: Operation {
    
    private var _image: UIImage?
    private let url: URL
    
    var image: UIImage? {
        get {return _image}
    }
    
    init(withURL: URL) {
        url = withURL
        super.init()
    }
    
    func main(lastURL: String?, onSccuess: @escaping ()->Void){
        
        if let image = imageCache.object(forKey: url.absoluteString as NSString) {
            self._image = image
            print("getting from cache")
            onSccuess()
            return
        }
        
        if url.absoluteString != lastURL {
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {return}
        let img = UIImage(data: data)
        guard let imgValue = img else {return}
        print("downloading data")
        imageCache.setObject(imgValue, forKey: url.absoluteString as NSString)
        _image = imgValue
        onSccuess()
    }
}
