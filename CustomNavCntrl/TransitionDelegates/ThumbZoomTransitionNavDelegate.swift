//
//  ThumbZoomTransitionNavDelegate.swift
//  CustomNavCntrl
//
//  Created by Shuvo on 8/14/17.
//  Copyright © 2017 Shuvo. All rights reserved.
//

import UIKit

class ThumbZoomTransitionNavDelegate: NSObject, UINavigationControllerDelegate {

    var originView: UIView?
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let thumbnailZoomTransitionAnimator = ThumbnailZoomTransitionAnimator()
        
        if operation == .push {
            // Pass the thumbnail frame to the transition animator.
            guard let transitionThumbnail = originView, let transitionThumbnailSuperview = transitionThumbnail.superview else { return nil }
            
            thumbnailZoomTransitionAnimator.thumbnailFrame = transitionThumbnailSuperview.convert(transitionThumbnail.frame, to: nil)
        }
        thumbnailZoomTransitionAnimator.operation = operation
        
        return thumbnailZoomTransitionAnimator
    }
}
