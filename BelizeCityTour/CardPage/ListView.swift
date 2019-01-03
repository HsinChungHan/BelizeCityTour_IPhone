//
//  ListView.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/8.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ListView: BasicView {
    
    lazy var monumentButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(btnFunc), for: .touchUpInside)
        btn.setImage(UIImage(named: IconsConstant.menuMonument.rawValue )?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var foodButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(btnFunc), for: .touchUpInside)
        btn.setImage(UIImage(named: IconsConstant.menuFood.rawValue )?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    lazy var eventButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(btnFunc), for: .touchUpInside)
        btn.setImage(UIImage(named: IconsConstant.menuEvents.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    @objc func btnFunc(){
        print("You tapped me")
    }
    
    
    override func setupViews() {
        
        let stackView = UIStackView()
        stackView.setupStackView(views: [monumentButton, foodButton, eventButton], axis: .vertical, distribution: .fillEqually , spacing: 10)
        addSubview(stackView)
        stackView.fullAnchor(superView: self)
    }
}
