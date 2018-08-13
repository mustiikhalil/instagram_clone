//
//  MKButton.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 7/29/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class MKButton: UIButton {
	
	init() {
		super.init(frame: .zero)
	}
    
    func setUpLoginAndSignUPButtons(title: ButtonType, titleColor: UIColor, backgroundColor background: UIColor, raduis: CGFloat) {
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        setTitle(title.ID(), for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = background
        layer.cornerRadius = raduis
    }
    
    func setupMainViewButtons(type: ButtonType) {
        switch type {
        case .comment:
            createButtonWith(image: #imageLiteral(resourceName: "comment"))
        case .heart:
            createButtonWith(image: #imageLiteral(resourceName: "like_unselected"))
        case .ribbon:
            createButtonWith(image: #imageLiteral(resourceName: "ribbon"))
        case .share:
            createButtonWith(image: #imageLiteral(resourceName: "send2"))
        case .options:
            createOptionsButton()
        default:
            fatalError()
        }
    }
    
    fileprivate func createButtonWith(image: UIImage) {
        setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
    }
    fileprivate func createOptionsButton() {
        setTitle("•••", for: .normal)
        setTitleColor(.black, for: .normal)
    }
    
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
