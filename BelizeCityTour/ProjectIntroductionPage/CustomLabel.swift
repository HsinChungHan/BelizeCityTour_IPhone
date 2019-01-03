//
//  CustomLabel.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class CustomLabel: UILabel {

    var insetEdge:UIEdgeInsets!
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insetEdge))
    }

}
