//
//  CircleTransitionAnimatorDismiss.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/14/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class CircleTransitionAnimatorDismiss: CircleAnimator, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        // Determine which is the master view and which is the detail view that we're navigating to and from. The container view will house the views for transition animation.
        
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toView)
        containerView.addSubview(fromView)
        
        
        // define the end frame for oval shape
        //let bigCirclePath = UIBezierPath(ovalIn: endFrame)
        
        let centerPoint = CGPoint(x: originFrame.midX, y: originFrame.midY)
        let bigCirclePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        // define the masking layer to be able to show that circle animation
        let maskLayer = CAShapeLayer()
        maskLayer.frame = fromView.frame
        maskLayer.path = bigCirclePath.cgPath
        fromView.layer.mask = maskLayer
        
        let maskPath = UIBezierPath(ovalIn: originFrame)
        
        /* CATransaction is used to avoid setting CABasicAnimation
         * instance delegate to self.
         * As setting the delegate to self causes
         * strong reference cycle while using CircleTransitionAnimator in
         * Custom classes that conforms UINavigationControllerDelegate.
         */
        CATransaction.begin()
        CATransaction.setCompletionBlock({ [weak self] in
            if let transitionContext = self?.transitionContext {
                transitionContext.completeTransition(true)
            }
        })
        
        // create the animation
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = bigCirclePath
        pathAnimation.toValue = maskPath.cgPath
        pathAnimation.duration = duration
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        maskLayer.path = bigCirclePath.cgPath
        maskLayer.add(pathAnimation, forKey: "pathCloseAnimation")
        
        CATransaction.commit()
    }
    
}
