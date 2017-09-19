//
//  CircleTransitonDelegate.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/14/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class CircleTransitonDelegate: NSObject, UIViewControllerTransitioningDelegate {

    var originView: UIView?
    var duration: TimeInterval = 0.3
    var radiusScaleFactor: CGFloat = 1.5
    
    
    /// optional/convenience initialization for CircleTransitionNavDelegate
    ///
    /// - Parameters:
    ///   - duration: Transition period. Default is 0.3
    ///   - radiusScaleFactor: This param will be multiplied with main screen
    ///     width to get radius of the circle. Default is 1.54
    convenience init(_ duration: TimeInterval, radiusScaleFactor:CGFloat) {
        self.init()
        
        self.duration = duration
        self.radiusScaleFactor = radiusScaleFactor
        
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let originFrame = originView?.frame else {return nil}
        let animator = CircleTransitionAnimator()
        animator.originFrame = originFrame
        animator.duration = duration
        animator.radiusScaleFactor = radiusScaleFactor
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let originFrame = originView?.frame else {return nil}
        let dismissAnimator = CircleTransitionAnimatorDismiss()
        dismissAnimator.originFrame = originFrame
        dismissAnimator.duration = duration
        dismissAnimator.radiusScaleFactor = radiusScaleFactor
        return dismissAnimator
    }
    
    
}
