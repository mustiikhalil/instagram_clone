//
//  UIImage.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/20/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit


extension UIImage {
    
    func getInstagramImage(x: CGFloat, y: CGFloat, frame: CGRect) -> UIImage {
        let imgOrigin = CGPoint(x: x, y: 0)
        guard let imageRef = self.cgImage?.cropping(to: CGRect(origin: imgOrigin, size: CGSize(width: 1090, height: 1090))) else {
            print("Fail to crop image")
            return UIImage()
        }
        return UIImage(cgImage: imageRef, scale: 0.0, orientation: .right)
    }
}

