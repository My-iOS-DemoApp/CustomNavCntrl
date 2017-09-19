//
//  CircleAnimator.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/14/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class CircleAnimator: NSObject {

    var transitionContext: UIViewControllerContextTransitioning?
    var originFrame = CGRect.zero
    var duration: TimeInterval = 0
    var radiusScaleFactor: CGFloat = 1 {
        didSet{
            radius = mainFrame.size.width * radiusScaleFactor
        }
    }
    
    //MARK:- Read Only Property
    
    
    /// circle radius. Read Only Property
    private(set) var radius: CGFloat
    
    let mainFrame = UIScreen.main.bounds
    let startAngle: CGFloat = 0
    let endAngle = CGFloat(2 * Double.pi)
    
    // For oval shape
    //    let endFrame = mainFrame.insetBy(dx: mainFrame.size.width * -0.2, dy: mainFrame.size.height * -0.2)

    override init() {
        
        radius = mainFrame.size.width * radiusScaleFactor
    }
}
