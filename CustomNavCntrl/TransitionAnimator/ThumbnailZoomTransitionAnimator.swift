//
//  ThumbnailZoomTransitionAnimator.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/13/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class ThumbnailZoomTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let duration: TimeInterval = 0.3
    var operation: UINavigationControllerOperation = .push
    var thumbnailFrame = CGRect.zero
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let presenting = operation == .push
        
        // Determine which is the master view and which is the detail view that we're navigating to and from. The container view will house the views for transition animation.
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        let storyFeedView = presenting ? fromView : toView
        let storyDetailView = presenting ? toView : fromView
        
        containerView.backgroundColor = fromView.backgroundColor
        
        // Determine the starting frame of the detail view for the animation. When we're presenting, the detail view will grow out of the thumbnail frame. When we're dismissing, the detail view will shrink back into that same thumbnail frame.
        var initialFrame = presenting ? thumbnailFrame : storyDetailView.frame
        let finalFrame = presenting ? storyDetailView.frame : thumbnailFrame
        
        // Resize the detail view to fit within the thumbnail's frame at the beginning of the push animation and at the end of the pop animation while maintaining it's inherent aspect ratio.
        let initialFrameAspectRatio = initialFrame.width / initialFrame.height
        let storyDetailAspectRatio = storyDetailView.frame.width / storyDetailView.frame.height
        if initialFrameAspectRatio > storyDetailAspectRatio {
            initialFrame.size = CGSize(width: initialFrame.height * storyDetailAspectRatio, height: initialFrame.height)
        }
        else {
            initialFrame.size = CGSize(width: initialFrame.width, height: initialFrame.width / storyDetailAspectRatio)
        }
        
        let finalFrameAspectRatio = finalFrame.width / finalFrame.height
        var resizedFinalFrame = finalFrame
        if finalFrameAspectRatio > storyDetailAspectRatio {
            resizedFinalFrame.size = CGSize(width: finalFrame.height * storyDetailAspectRatio, height: finalFrame.height)
        }
        else {
            resizedFinalFrame.size = CGSize(width: finalFrame.width, height: finalFrame.width / storyDetailAspectRatio)
        }
        
        // Determine how much the detail view needs to grow or shrink.
        let scaleFactor = resizedFinalFrame.width / initialFrame.width
        let growScaleFactor = presenting ? scaleFactor: 1/scaleFactor
        let shrinkScaleFactor = 1/growScaleFactor
        
        if presenting {
            // Shrink the detail view for the initial frame. The detail view will be scaled to CGAffineTransformIdentity below.
            storyDetailView.transform = CGAffineTransform(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
            storyDetailView.center = CGPoint(x: thumbnailFrame.midX, y: thumbnailFrame.midY)
            storyDetailView.clipsToBounds = true
        }
        
        // Set the initial state of the alpha for the master and detail views so that we can fade them in and out during the animation.
        storyDetailView.alpha = presenting ? 0 : 1
        storyFeedView.alpha = presenting ? 1 : 0
        
        // Add the view that we're transitioning to to the container view that houses the animation.
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: storyDetailView)
        
        // Animate the transition.
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1, initialSpringVelocity: 1.0, options: .curveEaseOut, animations: {
            // Fade the master and detail views in and out.
            storyDetailView.alpha = presenting ? 1 : 0
            storyFeedView.alpha = presenting ? 0 : 1
            
            if presenting {
                // Scale the master view in parallel with the detail view (which will grow to its inherent size). The translation gives the appearance that the anchor point for the zoom is the center of the thumbnail frame.
                let scale = CGAffineTransform(scaleX: growScaleFactor, y: growScaleFactor)
                let translate = storyFeedView.transform.translatedBy(x: storyFeedView.frame.midX - self.thumbnailFrame.midX, y: storyFeedView.frame.midY - self.thumbnailFrame.midY)
                storyFeedView.transform = translate.concatenating(scale)
                storyDetailView.transform = .identity
            }
            else {
                // Return the master view to its inherent size and position and shrink the detail view.
                storyFeedView.transform = .identity
                storyDetailView.transform = CGAffineTransform(scaleX: shrinkScaleFactor, y: shrinkScaleFactor)
            }
            
            // Move the detail view to the final frame position.
            storyDetailView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
        }) { finished in
            containerView.backgroundColor = .clear
            transitionContext.completeTransition(finished)
        }
    }
    
    
    
}
