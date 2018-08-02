//
//  Layout.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/2/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class Layout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        sectionInsetReference = .fromSafeArea
    }
}
