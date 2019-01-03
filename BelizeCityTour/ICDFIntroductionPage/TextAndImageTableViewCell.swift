//
//  TextAndImageTableViewCell.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/29.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class TextAndImageTableViewCell: TextOnlyTableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var paragraphView: ParagraphView?
    var values: (upperColor: UIColor, lowerColor: UIColor, image: UIImage, paragraphText: String)?{
        didSet{
            paragraphView = ParagraphView.init(upperColor: (values?.upperColor)!, lowerColor: (values?.lowerColor)!, image: (values?.image)!)
            super.setupValue(paragraphText: values!.paragraphText, upperBGColor: values!.lowerColor, lowerBGColor: values!.upperColor)
            setupViews()
        }
    }
    
    override func setupViews() {
        super.setupViews()
        paragraphLabel.removeFromSuperview()
        guard let paragraphView = paragraphView else {return}
        paragraphLabel.textColor = .white
        addSubview(paragraphView)
        paragraphView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: ICDFINtroductionConstant.ParagraphImageViewHeight.rawValue)
        addSubview(paragraphLabel)
        paragraphLabel.anchor(top: paragraphView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 10, leftPadding: 10, rightPadding: 10, width: 0, height: 0)
    }
    
    func setupValue(values: (upperColor: UIColor, lowerColor: UIColor, image: UIImage, paragraphText: String)){
        self.values = values
    }
    
    
}
