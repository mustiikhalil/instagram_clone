//
//  LibraryPhotoSelectorHeaderCell.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/8/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class LibraryPhotoSelectorHeaderCell: UICollectionReusableView {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var item: UIImage? {
        didSet {
            self.setImage(item: item)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        addSubview(imageView)
        imageView.anchor(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
    }
    
    fileprivate func setImage(item: UIImage?) {
        guard let image = item else {return}
        imageView.image = image
    }
}
