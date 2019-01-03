//
//  SlideLeftTransitionAnimation.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/1.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class SlideLeftTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    let duration = 1.0
    var isPresenting = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // Get reference to our fromView, toView and the container view
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else {
            return
        }
        
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        
        // Set up the transform we'll use in the animation
        let container = transitionContext.containerView
        
        let offScreenRight = CGAffineTransform(translationX: -container.frame.width, y: 0)

        let offScreenLeft = CGAffineTransform(translationX: container.frame.width , y: 0)
        
        
        
        // Make the toView off screen
        if isPresenting {
            toView.transform = offScreenLeft
//            toView.transform = offScreenLeft
        }
        
        container.addSubview(fromView)
        container.addSubview(toView)
        
        // Add both views to the container view
//        if isPresenting {
//            container.addSubview(fromView)
//            container.addSubview(toView)
//        } else {
//            container.addSubview(toView)
//            container.addSubview(fromView)
//        }
        
        // Perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            
            if self.isPresenting {
                fromView.transform = offScreenRight
                fromView.alpha = 0.5
                //讓toView左上角的座標變為(0,0)
                toView.transform = CGAffineTransform.identity
            } else {
//                fromView.transform = offScreenLeft
                fromView.transform = offScreenLeft
                fromView.alpha = 1.0
                toView.transform = CGAffineTransform.identity
                toView.alpha = 1.0
            }
            
        }, completion: { finished in
            
            transitionContext.completeTransition(true)
            
        })
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }
    
}
