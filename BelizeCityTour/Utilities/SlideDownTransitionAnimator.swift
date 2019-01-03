//
//  SlideDownTransitionAnimator.swift
//  NaviTransitionTraning
//
//  Created by 辛忠翰 on 2018/6/12.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

//讓原本的視圖往下滑消失，新的視圖由上往下滑取代舊的視圖
class SlideDownTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    //來追蹤目前viewControlller處於presented或dismiss的狀態
    var isPresenting = false
    
    
    //在view要presented或dismiss時用，使用這個動畫物件
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        isPresenting = false
        return self
    }
    
    
    //這個轉場動畫要多久
    let duration = 1.5
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    //轉場動畫發生的地方
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //為目前的VC
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from ) else {
            return
        }
        
        //為後來要轉場的VC
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else {
            return
        }
        
        //設定我們要使用在動畫中的過場
        //這個container為參與轉場的所有視圖的父視圖
        let container = transitionContext.containerView
        //offScreenUp是給toView的起始位置，一開始在整個螢幕的上方
        let offScreenUp = CGAffineTransform(translationX: 0, y: -container.frame.height)
        //offScreenDown是給fromView的起始位置，一開始在整個螢幕
        let offScreenDown = CGAffineTransform(translationX: 0, y: container.frame.height)
        
        //讓toView離開畫面
        if isPresenting{
            toView.transform = offScreenUp
        }
        
        
        container.addSubview(fromView)
        container.addSubview(toView)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            if self.isPresenting{
                fromView.transform = offScreenDown
                fromView.alpha = 0.5
                //讓toView左上角的座標變為(0,0)
                toView.transform = CGAffineTransform.identity
            }else{
                fromView.transform = offScreenUp
                fromView.alpha = 1.0
                toView.transform = CGAffineTransform.identity
                toView.alpha = 1.0
            }
        }) { _ in
            transitionContext.completeTransition(true)
        }
        
    }
}
