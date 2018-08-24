//
//  PreviewPhotoContainerView.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/21/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

protocol SaveImageTaken {
    func save(image: UIImage)
}

class PreviewPhotoContainer: UIView {
    
    let previewImageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    let cancelButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "cancel_shadow")
        btn.setImage( image?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return btn
    }()
    
    
    let saveButton: UIButton = {
        let btn = UIButton(type: .system)
        let image = UIImage(named: "save_shadow")
        btn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return btn
    }()
    
    var image: UIImage? {
        didSet {
            self.previewImageView.image = image
        }
    }
    
    var saveImage: SaveImageTaken?
    
    @objc func handleCancel() {
        self.removeFromSuperview()
    }
    
    @objc func handleSave() {
        guard let img = image else { return }
        saveImage?.save(image: img)
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellow
        addSubview(previewImageView)
        addSubview(cancelButton)
        addSubview(saveButton)
        previewImageView.anchor(leading: leadingAnchor, top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, paddingLeading: 0, paddingTop: 0, paddingTailing: 0, paddingBottom: 0, width: 0, height: 0)
        cancelButton.anchor(leading: nil, top: topAnchor, trailing: trailingAnchor, bottom: nil, paddingLeading: 0, paddingTop: 30, paddingTailing: 8, paddingBottom: 0, width: 50, height: 50)
        saveButton.anchor(leading: leadingAnchor, top: nil, trailing: nil, bottom: bottomAnchor, paddingLeading: 8, paddingTop: 0, paddingTailing: 0, paddingBottom: 30, width: 50, height: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
