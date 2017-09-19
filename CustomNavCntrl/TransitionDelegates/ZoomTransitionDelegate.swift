//
//  ZoomTransitionDelegate.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/22/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class ZoomTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    var originView: UIView?
    var duration: TimeInterval = 0.3
    
    /// optional/convenience initialization for CircleTransitionNavDelegate
    ///
    /// - Parameters:
    ///   - duration: Transition period. Default is 0.3
    convenience init(_ duration: TimeInterval) {
        self.init()
        
        self.duration = duration
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let originFrame = originView?.frame else {return nil}
        let animator = ZoomTransitionAnimator()
        animator.originFrame = originFrame
        animator.duration = duration
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let originFrame = originView?.frame else {return nil}
        let dismissAnimator = ZoomTransitionAnimatorDismiss()
        dismissAnimator.originFrame = originFrame
        dismissAnimator.duration = duration
        return dismissAnimator
    }
    
}
