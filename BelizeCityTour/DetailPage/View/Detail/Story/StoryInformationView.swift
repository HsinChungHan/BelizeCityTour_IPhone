//
//  StoryInformationView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/8.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

enum ViewType{
    case imgLeft
    case imgRight
    case imgMiddle
}

class StoryLabel: UILabel{
    let inset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
    override func draw(_ rect: CGRect) {
        
        super.drawText(in: rect.inset(by: inset))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        font = UIFont.systemFont(ofSize: 22)
        textColor = UIColor.lightGrayText
        
        numberOfLines = 0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class StoryInformationView: UIView {
    var labelText: String
    
    var imgAnchor: (leftAnchor: NSLayoutXAxisAnchor?, rightAnchor: NSLayoutXAxisAnchor? , leftPadding: CGFloat, rightPadding: CGFloat)?
    var labelAnchor: (leftAnchor: NSLayoutXAxisAnchor?, rightAnchor: NSLayoutXAxisAnchor?, topAnchor: NSLayoutYAxisAnchor? , bottomAnchor: NSLayoutYAxisAnchor?)?
    
    init(viewType: ViewType, image: String, text: String) {
        self.labelText = text
        super.init(frame: .zero)
        setLocation(viewType: viewType)
        setupViews()
        setContent(image: image, text: text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var imgView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        imv.image = UIImage(named: "test1")
        return imv
    }()
    
    let storyLabel = StoryLabel()
    
    fileprivate func setLocation(viewType: ViewType){
        switch viewType {
        case .imgLeft:
            imgAnchor = (leftAnchor: leftAnchor, rightAnchor: nil, leftPadding: 20, rightPadding: 0)
            labelAnchor = (leftAnchor: imgView.rightAnchor, rightAnchor: rightAnchor, topAnchor: imgView.topAnchor , bottomAnchor: imgView.bottomAnchor)
        case .imgRight:
            imgAnchor = (leftAnchor: nil, rightAnchor: rightAnchor, leftPadding: 0, rightPadding: 20)
            labelAnchor = (leftAnchor: leftAnchor, rightAnchor: imgView.leftAnchor,  topAnchor: imgView.topAnchor , bottomAnchor: imgView.bottomAnchor)
        case.imgMiddle:
            imgAnchor = (leftAnchor: leftAnchor, rightAnchor: rightAnchor, leftPadding: 10, rightPadding: 10)
            labelAnchor = (leftAnchor: leftAnchor, rightAnchor: rightAnchor, topAnchor: imgView.bottomAnchor, bottomAnchor: nil)
        }
    }
    
    fileprivate func setupViews() {
        backgroundColor = .clear
        addSubview(imgView)
        addSubview(storyLabel)
        imgView.anchor(top: topAnchor, bottom: nil, left: imgAnchor?.leftAnchor, right: imgAnchor?.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: (imgAnchor?.leftPadding)!, rightPadding: (imgAnchor?.rightPadding)!, width: 0, height: UIScreen.main.bounds.width / 2)
//        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        storyLabel.anchor(top: labelAnchor?.topAnchor, bottom: labelAnchor?.bottomAnchor, left: labelAnchor?.leftAnchor, right: labelAnchor?.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: storyLabel.getLabelHegit(str: labelText, font: storyLabel.font, width: UIScreen.main.bounds.width - 20) + 80)
    }
    
    fileprivate func setContent(image: String, text: String){
        imgView.image = UIImage(named: image)
        storyLabel.text = text
    }
}
