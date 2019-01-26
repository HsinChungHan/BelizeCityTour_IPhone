//
//  PlaceButton.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
protocol PlaceButtonDelegate {
    func buttonTap(sender: PlaceButton, place: Place)
}


class PlaceButton: UIButton {
    var delegate: PlaceButtonDelegate?
    var place: Place
    
    init(index: Int, place: Place) {
        self.place = place
        super.init(frame: CGRect(x: place.iconLocation.x , y: place.iconLocation.y, width: 65, height: 65))
        tag = index
        imageView?.contentMode = .scaleAspectFit
        setImage(UIImage(named: place.iconImg)!.withRenderingMode(.alwaysOriginal), for: .normal)
        addTarget(self, action: #selector(handelPlaceButtnTap(sender:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handelPlaceButtnTap(sender: PlaceButton){
        delegate?.buttonTap(sender: sender, place: place)
    }
    
    
}
