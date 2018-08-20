//
//  CaptureButton.swift
//  instagramClone
//
//  Created by Mustafa Khalil on 8/20/18.
//  Copyright © 2018 Mustafa Khalil. All rights reserved.
//

import UIKit

class CaptureButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let radius = frame.width/2
        layer.cornerRadius = radius
        let buttonShape = CAShapeLayer()
        let circularPath = UIBezierPath(arcCenter: layer.position, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        buttonShape.strokeColor = UIColor.rgb(red: 220, green: 220, blue: 220).cgColor
        buttonShape.fillColor = UIColor.white.cgColor
        buttonShape.lineWidth = 16
        buttonShape.path = circularPath.cgPath
        buttonShape.anchorPoint = layer.anchorPoint
        layer.addSublayer(buttonShape)
        layer.masksToBounds = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

