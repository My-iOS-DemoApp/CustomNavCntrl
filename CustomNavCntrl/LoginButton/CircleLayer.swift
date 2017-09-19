//
//  CircleLayer.swift
//  ButtonAnimation
//
//  Created by Shuvo on 8/19/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class CircleLayer: CAShapeLayer {

    var circleColor = UIColor.white {
        didSet {
            strokeColor = circleColor.cgColor
        }
    }
    
    init(frame:CGRect) {
        super.init()
        
        let radius:CGFloat = (frame.height / 2) * 0.5
        self.frame = CGRect(x: 0, y: 0, width: frame.height, height: frame.height)
        
        let center = CGPoint(x: frame.height / 2, y: bounds.midY)
        let startAngle = 0
        let endAngle = Double.pi * 2
        let clockwise: Bool = true
        self.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).cgPath
        
        self.fillColor = nil
        self.strokeColor = circleColor.cgColor
        self.lineWidth = 1
        
        self.strokeEnd = 0.6
        self.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animation() {
        self.isHidden = false
        let rotate = SMAnimation.rotate()
        self.add(rotate, forKey: rotate.keyPath)
        
    }
    
    func stopAnimation() {
        self.isHidden = true
        self.removeAllAnimations()
    }
}
