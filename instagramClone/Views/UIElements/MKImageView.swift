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
            imgDownloader.main(lastURL: self.lastURLUsedToLoadImage) { img in
                DispatchQueue.main.async {
                    self.image = img
                }
//                OperationQueue.main.addOperation {
//                    self.image = img
//                }
            }
        }
    }
}
