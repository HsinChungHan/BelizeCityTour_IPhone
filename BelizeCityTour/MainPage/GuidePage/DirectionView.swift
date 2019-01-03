//
//  DirectionView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/13.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

enum ArrowType: String{
    case rightDirectionArrow
    case leftDirectionArrow
}

class DirectionView: BasicView {
    init(clue: String, arrow: ArrowType){
        super.init(frame: .zero)
        directionArrowImgView.image = UIImage(named: arrow.rawValue)?.withRenderingMode(.alwaysTemplate)
        clueLabel.text = clue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let directionArrowImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "rightDirectionArrow")?.withRenderingMode(.alwaysTemplate)
        imv.contentMode = .scaleAspectFit
        imv.tintColor = .white
        imv.tintColor = .white
        return imv
    }()
    
    let clueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        return label
    }()
    override func setupViews() {
        setupAllViews()
    }
}


extension DirectionView{
    fileprivate func setupAllViews(){
        addSubview(directionArrowImgView)
        addSubview(clueLabel)
        directionArrowImgView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 100)
        clueLabel.anchor(top: directionArrowImgView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
    }
}
