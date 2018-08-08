//
//  LibraryPhotoSelectorCell.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/7/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class LibraryPhotoSelectorCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var item: Photo? {
        didSet {
            guard let lowResImage = item?.lowResImage else {return}
            imageView.image = lowResImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(imageView)
        imageView.anchor(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
}
