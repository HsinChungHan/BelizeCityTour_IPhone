//
//  PathView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/7/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class PathView: UIView {
    
    var path: UIBezierPath?{
        didSet{
            draw(frame)
            print("view.frame = ", frame)
        }
    }
    
    override func draw(_ rect: CGRect) {
        path?.stroke()
    }
    
    func customPath(startPoint: CGPoint, endPoint: CGPoint, startAndEndSuperView: UIView, lineWidth: CGFloat){
        startAndEndSuperView.layoutIfNeeded()
        let path = UIBezierPath()
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.lineWidth = lineWidth
        self.path = path
    }
    
    func customPath(startView: UIView, endView: UIView, startAndEndSuperView: UIView, lineWidth: CGFloat){
        startAndEndSuperView.layoutIfNeeded()
        let path = UIBezierPath()
        let startPointX = startView.frame.origin.x + startView.frame.width / 2
        let startPointY = startView.frame.origin.y + startView.frame.height / 2
        let startPoint = CGPoint(x: startPointX, y: startPointY)
        let endPoint = endView.frame.origin
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        path.lineWidth = lineWidth
        self.path = path
    }

    func fetchPath() -> CGPath?{
        guard let path = path else {return nil}
        return path.cgPath
    }
    
}
