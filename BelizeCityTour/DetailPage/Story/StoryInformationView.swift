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
}

class StoryInformationView: UIView {
    
    var imgAnchor: (leftAnchor: NSLayoutXAxisAnchor?, rightAnchor: NSLayoutXAxisAnchor? , leftPadding: CGFloat, rightPadding: CGFloat)?
    var labelAnchor: (leftAnchor: NSLayoutXAxisAnchor?, rightAnchor: NSLayoutXAxisAnchor?)?
    
    init(viewType: ViewType, image: String, text: String) {
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
    
    let storylabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    fileprivate func setLocation(viewType: ViewType){
        switch viewType {
        case .imgLeft:
            imgAnchor = (leftAnchor: leftAnchor, rightAnchor: nil, leftPadding: 20, rightPadding: 0)
            labelAnchor = (leftAnchor: imgView.rightAnchor, rightAnchor: rightAnchor)
        case .imgRight:
            imgAnchor = (leftAnchor: nil, rightAnchor: rightAnchor, leftPadding: 0, rightPadding: 20)
            labelAnchor = (leftAnchor: leftAnchor, rightAnchor: imgView.leftAnchor)
        }
    }
    
    fileprivate func setupViews() {
        backgroundColor = .clear
        addSubview(imgView)
        addSubview(storylabel)
        imgView.anchor(top: nil, bottom: nil, left: imgAnchor?.leftAnchor, right: imgAnchor?.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: (imgAnchor?.leftPadding)!, rightPadding: (imgAnchor?.rightPadding)!, width: UIScreen.main.bounds.width/2, height: 300)
        imgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        storylabel.anchor(top: imgView.topAnchor, bottom: imgView.bottomAnchor, left: labelAnchor?.leftAnchor, right: labelAnchor?.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 20, rightPadding: 20, width: 0, height: 0)
    }
    
    fileprivate func setContent(image: String, text: String){
        imgView.image = UIImage(named: image)
        storylabel.text = text
    }
}
