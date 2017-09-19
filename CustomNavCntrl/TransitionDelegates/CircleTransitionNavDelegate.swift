//
//  CircleTransitionNavDelegate.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/14/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class CircleTransitionNavDelegate: NSObject, UINavigationControllerDelegate {
    
    var originView: UIView?
    var duration: TimeInterval = 0.3
    var radiusScaleFactor: CGFloat = 1.5
    
    private weak var firstFromVC: UIViewController?
    private weak var firstToVC: UIViewController?
    
    
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
            let animator = CircleTransitionAnimator()
            animator.originFrame = originFrame
            animator.duration = duration
            animator.radiusScaleFactor = radiusScaleFactor
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
            
            let dismissAnimator = CircleTransitionAnimatorDismiss()
            dismissAnimator.originFrame = originFrame
            dismissAnimator.duration = duration
            dismissAnimator.radiusScaleFactor = radiusScaleFactor
            return firstToVC === fromVC ? dismissAnimator : nil
        }
        
    }
    
}
