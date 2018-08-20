//
//  UIImage.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/20/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit


extension UIImage {
    
    func getInstagramImage(x: CGFloat, y: CGFloat, size: CGSize) -> UIImage {
        let imgOrigin = CGPoint(x: x, y: y)
        guard let imageRef = self.cgImage?.cropping(to: CGRect(origin: imgOrigin, size: size)) else {
            print("Fail to crop image")
            return UIImage()
        }
        return UIImage(cgImage: imageRef, scale: 1.0, orientation: .down)
    }
}

