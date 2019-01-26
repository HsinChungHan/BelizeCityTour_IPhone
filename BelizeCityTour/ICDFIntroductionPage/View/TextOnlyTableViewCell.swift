//
//  TextOnlyTableViewCell.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/29.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit


class TextOnlyTableViewCell: UITableViewCell {
    
    
    
    var paragraphText: String?{
        didSet{
            paragraphLabel.text = paragraphText
            paragraphLabel.setLineSpacing(str: paragraphText!, spacing: 12)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let upperBackgroundView = UIView()
    let lowerBackgroundView = UIView()
    
    let paragraphLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "FranklinGothic-Demi", size: 25)
        label.textColor = UIColor.rgb(red: 72, green: 45, blue: 31)
        label.numberOfLines = 0
        return label
    }()
    
    
    
    func setupViews(){
        addSubview(upperBackgroundView)
        addSubview(lowerBackgroundView)
        upperBackgroundView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: ICDFINtroductionConstant.ParagraphImageViewHeight.rawValue/2)
        lowerBackgroundView.anchor(top: upperBackgroundView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        addSubview(paragraphLabel)
        paragraphLabel.fullAnchor(superView: self, topPadding: 10, bottomPadding: 10, leftPadding: 10, rightPadding: 10)
    }
    
    func setupValue(paragraphText: String, upperBGColor: UIColor, lowerBGColor: UIColor) {
        self.paragraphText = paragraphText
        upperBackgroundView.backgroundColor = upperBGColor
        lowerBackgroundView.backgroundColor = lowerBGColor
    }
}
