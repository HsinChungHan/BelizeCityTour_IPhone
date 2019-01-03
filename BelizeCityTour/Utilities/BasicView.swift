//
//  BasicView.swift
//  TrafficInBelize
//
//  Created by 辛忠翰 on 18/04/18.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class BasicView: UIView {
//    var backgroundImgView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        addSubview(backgroundImgView)
//        backgroundImgView.fullAnchor(superView: self)
//        backgroundImgView.contentMode = .scaleAspectFill
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
    }

}
