//
//  SMAnimation.swift
//  ButtonAnimation
//
//  Created by Shuvo on 8/19/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import QuartzCore

struct SMAnimation {
    
    private static let TIMING_FUNCTION = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    static func rotate(keyPath path:String = "transform.rotation.z",
                       duration:TimeInterval = 0.4) -> CABasicAnimation {
        
        let rotate = CABasicAnimation(keyPath: path)
        rotate.fromValue = 0
        rotate.toValue = Double.pi * 2
        rotate.duration = duration
        rotate.timingFunction = TIMING_FUNCTION
        rotate.repeatCount = HUGE
        rotate.fillMode = kCAFillModeForwards
        rotate.isRemovedOnCompletion = false
        return rotate
    }
    
    static func shrink(keyPath path:String = "bounds.size.width",
                       from:Any?,
                       to:Any?,
                       duration:TimeInterval = 0.1 ) -> CABasicAnimation {
        
        let shrink = CABasicAnimation(keyPath: path)
        shrink.fromValue = from
        shrink.toValue = to
        shrink.duration = duration
        shrink.timingFunction = TIMING_FUNCTION
        shrink.fillMode = kCAFillModeForwards
        shrink.isRemovedOnCompletion = false
        return shrink
    }
}
