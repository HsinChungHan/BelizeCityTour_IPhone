//
//  ICDFIntroduction.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/10/7.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit
class ICDFIntrodutionParagraph{
    let paragraphText: String, image: UIImage?, upperImgColor: UIColor, lowerImgColor: UIColor, upperBackgroundColor: UIColor, lowerBackgroundColor: UIColor, textColor: UIColor
    init(paragraphText: String, image: UIImage?, upperImgColor: UIColor, lowerImgColor: UIColor, upperBackgroundColor: UIColor, lowerBackgroundColor: UIColor, textColor: UIColor) {
        self.paragraphText = paragraphText
        self.image = image
        self.upperImgColor = upperImgColor
        self.lowerImgColor = lowerImgColor
        self.upperBackgroundColor = upperBackgroundColor
        self.lowerBackgroundColor = lowerBackgroundColor
        self.textColor = textColor
    }
    
    static func getAllParagraphs() -> ([ICDFIntrodutionParagraph]){
        guard let secondImg = UIImage(named: "Project1"),
            let thirdImg = UIImage(named: "Project2"),
            let forthImg = UIImage(named: "Project3")
            else {return []}
        
        let firstParagraph = ICDFIntrodutionParagraph.init(paragraphText: ICDFINtroductionText.firstParagraph.rawValue, image: nil, upperImgColor: UIColor.clear, lowerImgColor: UIColor.clear, upperBackgroundColor: UIColor.white, lowerBackgroundColor: UIColor.white, textColor: UIColor.introductionTextColor)
        let secondParagraph = ICDFIntrodutionParagraph.init(paragraphText: ICDFINtroductionText.secondParagraph.rawValue, image: secondImg , upperImgColor: UIColor.appleGreenBackgroundColor, lowerImgColor: UIColor.white, upperBackgroundColor: UIColor.white, lowerBackgroundColor: UIColor.appleGreenBackgroundColor, textColor: UIColor.white)
        let thirdParagraph = ICDFIntrodutionParagraph.init(paragraphText: ICDFINtroductionText.thirdParagraph.rawValue, image: thirdImg , upperImgColor: UIColor.deepGreenBackgroundColor, lowerImgColor: UIColor.appleGreenBackgroundColor, upperBackgroundColor: UIColor.appleGreenBackgroundColor, lowerBackgroundColor: UIColor.deepGreenBackgroundColor, textColor: UIColor.white)
        let forthParagraph = ICDFIntrodutionParagraph.init(paragraphText: ICDFINtroductionText.forthParagraph.rawValue, image: forthImg , upperImgColor: UIColor.blueBackgroundColor, lowerImgColor: UIColor.deepGreenBackgroundColor, upperBackgroundColor: UIColor.deepGreenBackgroundColor, lowerBackgroundColor: UIColor.blueBackgroundColor, textColor: UIColor.white)
        return [firstParagraph, secondParagraph, thirdParagraph, forthParagraph]
    }
}
