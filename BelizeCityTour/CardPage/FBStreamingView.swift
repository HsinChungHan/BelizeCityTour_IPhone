//
//  FBStreamingView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/6.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class FBStreamingView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
    }

    public override class var layerClass: Swift.AnyClass {
        return AnimatedLayer.self
    }

}
