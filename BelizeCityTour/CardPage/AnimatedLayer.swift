//
//  AnimatedLayer.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/5.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class AnimatedLayer: CALayer {
    override func display() {
        setAnimation()
    }
    
    override class func needsDisplay(forKey key: String) -> Bool {
        if key == "position" {
            return true
        }
        return super.needsDisplay(forKey: key)
    }
}

extension AnimatedLayer{
    fileprivate func customPath(startPoint: CGPoint, endPoint: CGPoint,  curvePoint1 cp1: CGPoint, curvePoint2 cp2: CGPoint) -> UIBezierPath{
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        return path
    }
    
    fileprivate func setAnimation(){
        let animation = CAKeyframeAnimation(keyPath: "position")
        let startPoint = CGPoint(x: 0, y: 200)
//        let endPoint = CGPoint(x: self.frame.maxX + 20, y: 200)
        let endPoint = CGPoint(x: UIScreen.main.bounds.width/2 + 200, y: 200)

        let randomYShift = 200 + drand48()*300
        let cp1 = CGPoint(x: 100, y: 100 - randomYShift)
        let cp2 = CGPoint(x: 200, y: 300 + randomYShift)
        animation.path = customPath(startPoint: startPoint, endPoint: endPoint, curvePoint1: cp1, curvePoint2: cp2).cgPath
        //用duration來控制X的位移量
        let timeShift = drand48()*2
        animation.duration = 2.0 + timeShift
        //動畫完後移除這個icon
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        self.add(animation, forKey: "animation")
    }
}


extension AnimatedLayer : CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        print("Animation started")
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        NotificationCenter.default.post(name:  .removeView , object: nil)
        print("Animation stopped")
    }
}
