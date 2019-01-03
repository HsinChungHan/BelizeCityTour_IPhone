//
//  CustomPresentAnimationController.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/6.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class CustomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrameForVC = transitionContext.finalFrame(for: toViewController)
        let containerView = transitionContext.containerView
        let bounds = UIScreen.main.bounds
        //        toViewController.view.frame = CGRectOffset(finalFrameForVC, 0, bounds.size.height)
        toViewController.view.frame = finalFrameForVC.offsetBy(dx: 0, dy: -bounds.size.height)
        containerView.addSubview(toViewController.view)
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
            fromViewController.view.alpha = 0.5
            toViewController.view.frame = finalFrameForVC
        }) { (_) in
            transitionContext.completeTransition(true)
            fromViewController.view.alpha = 1.0
        }
        
    }
    
}
