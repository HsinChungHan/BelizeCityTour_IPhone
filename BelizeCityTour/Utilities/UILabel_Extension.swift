//
//  UILabel_Extension.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
extension UILabel{
    func getLabelWidth(str: String, font: UIFont, height: CGFloat)-> CGFloat {
        let statusLabelText = str as NSString
        let size = CGSize(width: CGFloat(MAXFLOAT), height: height)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font : font], context: nil).size
        return strSize.width
    }
    
    func getLabelHegit(str: String, font: UIFont, width: CGFloat)-> CGFloat {
        let statusLabelText: NSString = str as NSString
        let size = CGSize(width: width, height: CGFloat(MAXFLOAT))
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil).size
        return strSize.height
    }
    
    func setLineSpacing(str: String, spacing: CGFloat){
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = spacing
        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph]
        attributedText = NSAttributedString(string: str, attributes: attributes as [NSAttributedString.Key : Any])
    }
}
