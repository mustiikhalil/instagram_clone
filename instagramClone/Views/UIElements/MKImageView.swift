//
//  URLImageView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/10/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class MKImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func downloadImage(url: URL, postURL: String) {
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print(err)
                print("couldn't download the image")
                return
            }
            
            if url.absoluteString != postURL {
                return
            }
            
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
            }.resume()
    }
    
    func loadImage(url: String) {
        
        guard let imageURL = URL(string: url) else { return }
        downloadImage(url: imageURL, postURL: url)
    }
}
