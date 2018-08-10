//
//  SharingVC.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/8/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit
import Firebase

class SharingVC: UIViewController {
    
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
        
    var image: UIImage? {
        didSet {
            if let highResImage = image {
                imageView.image = highResImage
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
        
}
