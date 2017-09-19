//
//  ZoomTransitionAnimatorDismiss.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/21/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class ZoomTransitionAnimatorDismiss: ZoomAnimator, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        /* Determine which is the current view and which is the next view that 
         * we're navigating to and from. The container view will house the views 
         * for transition animation.
         */
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        
        // To avoid black screen while animating
        containerView.backgroundColor = fromView.backgroundColor
        
        /* Determine the starting frame of the current view for the animation. 
         * When we're dismissing, the current view will shrink back into the 
         * origin frame.
         */
        var initialFrame = fromView.frame
        let finalFrame = originFrame
        
        /* Resize the current view to fit within the origin's frame at the end of
         * the dismiss animation while maintaining it's inherent aspect ratio.
         */
        let initialFrameAspectRatio = initialFrame.width / initialFrame.height
        let currentViewAspectRatio = fromView.frame.width / fromView.frame.height
        if initialFrameAspectRatio > currentViewAspectRatio {
            initialFrame.size = CGSize(width: initialFrame.height * currentViewAspectRatio, height: initialFrame.height)
        }
        else {
            initialFrame.size = CGSize(width: initialFrame.width, height: initialFrame.width / currentViewAspectRatio)
        }
        
        let finalFrameAspectRatio = finalFrame.width / finalFrame.height
        var resizedFinalFrame = finalFrame
        if finalFrameAspectRatio > currentViewAspectRatio {
            resizedFinalFrame.size = CGSize(width: finalFrame.height * currentViewAspectRatio, height: finalFrame.height)
        }
        else {
            resizedFinalFrame.size = CGSize(width: finalFrame.width, height: finalFrame.width / currentViewAspectRatio)
        }
        
        // Determine how much the next view needs to shrink.
        let scaleFactor = resizedFinalFrame.width / initialFrame.width
        let growScaleFactor = 1/scaleFactor
        let shrinkScaleFactor = 1/growScaleFactor
        
        
        /* Set the initial state of the alpha for the current and next views so 
         * that we can fade them in and out during the animation.
         */
        fromView.alpha = 1
        toView.alpha = 0
        
        // Add the view that we're transitioning to the container view that houses the animation.
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: fromView)
        
        // Animate the transition.
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            // Fade the current and next views in and out.
            fromView.alpha = 0
            toView.alpha = 1
            
            
            // Keep the next View to its inherent size and position and shrink the current View.
            toView.transform = .identity
            fromView.transform = CGAffineTransform(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
            
            // Move the fromView to the final frame position.
            fromView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }) { finished in
            containerView.backgroundColor = .clear
            transitionContext.completeTransition(finished)
        }
    }
    
}
