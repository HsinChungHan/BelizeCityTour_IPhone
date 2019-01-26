//
//  MapTableViewCell.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class MapTableViewCell: BasicTableViewCell {
    override var place: Place? {
        didSet{
            guard let place = place else {return}
            mapImgView.image = UIImage(named: place.mapImg)
        }
    }
    
    lazy var mapImgView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    lazy var guideImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "Guides")
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    
    override func setupViews() {
        addSubview(mapImgView)
        mapImgView.fullAnchor(superView: self)
    
        addSubview(guideImgView)
        guideImgView.anchor(top: topAnchor, bottom: nil, left: nil, right: rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 0, rightPadding: 20, width: 100, height: 100)
    }
    
}
