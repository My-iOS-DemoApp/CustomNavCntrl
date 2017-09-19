//
//  CircleTransitionAnimator.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/14/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class CircleTransitionAnimator: CircleAnimator, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        // Determine which is the master view and which is the detail view that we're navigating to and from. The container view will house the views for transition animation.
        
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        let initialFrame:CGRect
        if originFrame.width != originFrame.height {
            /* center of initial frame should be equal to origin frame
             * so initialFrame's x = originFrame.midX - newWidth/2 */
            let newX = originFrame.midX - originFrame.height/2
            initialFrame = CGRect(x: newX, y: originFrame.origin.y, width: originFrame.height, height: originFrame.height)
        } else {
            initialFrame = originFrame
        }
        
        let maskPath = UIBezierPath(ovalIn: initialFrame)
        
        // define the masking layer to be able to show that circle animation
        let maskLayer = CAShapeLayer()
        maskLayer.frame = toView.frame
        maskLayer.path = maskPath.cgPath
        toView.layer.mask = maskLayer
        
        // define the end frame for oval shape
        //let bigCirclePath = UIBezierPath(ovalIn: endFrame)
        
        let centerPoint = CGPoint(x: initialFrame.midX, y: initialFrame.midY)
        let bigCirclePath = UIBezierPath(arcCenter: centerPoint, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
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
        pathAnimation.fromValue = maskPath.cgPath
        pathAnimation.toValue = bigCirclePath
        pathAnimation.duration = duration
        maskLayer.path = bigCirclePath.cgPath
        maskLayer.add(pathAnimation, forKey: "pathAnimation")
        
        CATransaction.commit()
    }
    
    
    
}
