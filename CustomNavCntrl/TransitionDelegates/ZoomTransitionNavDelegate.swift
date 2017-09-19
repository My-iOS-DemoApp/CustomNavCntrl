//
//  ZoomTransitionNavDelegate.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/21/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class ZoomTransitionNavDelegate: NSObject, UINavigationControllerDelegate {

    var originView: UIView?
    var duration: TimeInterval = 0.3
    
    private weak var firstFromVC: UIViewController?
    private weak var firstToVC: UIViewController?
    
    /// optional/convenience initialization for CircleTransitionNavDelegate
    ///
    /// - Parameters:
    ///   - duration: Transition period. Default is 0.3
    convenience init(_ duration: TimeInterval) {
        self.init()
        
        self.duration = duration
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        /* store the UIViewController instances
         * so that, transition will not apply to other view controllers.
         */
        if firstFromVC == nil {
            firstFromVC = fromVC
            firstToVC = toVC
        }
        
        guard let originFrame = originView?.frame  else {return nil}
        if operation == .push {
            let animator = ZoomTransitionAnimator()
            animator.originFrame = originFrame
            animator.duration = duration
            return firstFromVC === fromVC ? animator : nil
            
        } else {
            /* reset the firstFromVC to nil when applying dismissAnimator
             * so that, we can store the new intances of UIViewController
             * when pushing again. As firstFromVC and firstToVC will not
             * be nil before deinitialization of the implementing class.
             */
            if firstToVC === fromVC {
                firstFromVC = nil
            }
            
            let dismissAnimator = ZoomTransitionAnimatorDismiss()
            dismissAnimator.originFrame = originFrame
            dismissAnimator.duration = duration
            return firstToVC === fromVC ? dismissAnimator : nil
        }
        
    }
}
