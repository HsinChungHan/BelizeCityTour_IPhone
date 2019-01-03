//
//  TableHeaderView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2019/1/3.
//  Copyright © 2019 辛忠翰. All rights reserved.
//

import UIKit

protocol TableHeaderViewDelegate {
    func goToICDFWebsite(sender: UIImageView)
    func goToCultureWebsite(sender: UIImageView)
}

class TableHeaderView: UIView {
    var delegate: TableHeaderViewDelegate?
    
    lazy var icdfImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "icdfLogo")
        imv.contentMode = .scaleAspectFit
        imv.isUserInteractionEnabled = true
        imv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToICDFWebsite(sender:))))
        return imv
    }()
    
    
    @objc func goToICDFWebsite(sender:UIImageView){
        delegate?.goToICDFWebsite(sender: sender)
    }
    
    lazy var cultureImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "cultureLogo")
        imv.contentMode = .scaleAspectFit
        imv.isUserInteractionEnabled = true
        imv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToCultureWebsite(sender:))))
        return imv
    }()
    
    
    @objc func goToCultureWebsite(sender: UIImageView){
        delegate?.goToCultureWebsite(sender: sender)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.backgroundRiceColor.withAlphaComponent(0.8)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        let stackView = UIStackView()
        stackView.setupStackView(views: [cultureImgView, icdfImgView], axis: .horizontal, distribution: .fillProportionally , spacing: 20)
        addSubview(stackView)
        stackView.centerAnchor(superView: self, width: frame.width/1.5
            , height:  frame.height - 20)
    }
}
