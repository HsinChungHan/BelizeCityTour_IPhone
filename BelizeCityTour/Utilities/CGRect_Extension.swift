//
//  CGRect_Extension.swift
//  BelizeCityTour
//
//  Created by Chung Han Hsin on 2019/1/29.
//  Copyright © 2019 辛忠翰. All rights reserved.
//

import UIKit

extension CGRect{
    func autoSizingIconLocation() -> CGRect{
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let iPhone8PlusScreenWidth: CGFloat = 414
        let iPhone8PlusScreenHeight: CGFloat = 736
        
        return CGRect.init(x: minX/iPhone8PlusScreenWidth*screenWidth, y: minY/iPhone8PlusScreenHeight*screenHeight, width: width/iPhone8PlusScreenWidth*UIScreen.main.bounds.width, height: width/iPhone8PlusScreenWidth*UIScreen.main.bounds.width)
    }
}
