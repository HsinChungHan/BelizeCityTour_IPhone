//
//  InformationView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
let textBrownColor = UIColor.rgb(red: 132, green: 94, blue: 85)

protocol InformationViewDelegate {
    func goToWebSite(sender: UIButton, url: URL)
}


class InformationView: UIView {
    var delegate: InformationViewDelegate?
    init(image: UIImage, title: String, subTitle: String, isWebsite: Bool){
        super.init(frame: .zero)
        iconImgView.image = image
        titleLabel.text = title
        subTitleLabel.text = subTitle
        websiteButton.setTitle(subTitle, for: .normal)
        setupViews(isWebsite: isWebsite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let iconImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = textBrownColor
        return label
    }()
    
    fileprivate lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor.darkBlueColor
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var websiteButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(UIColor.systemBlue, for: .normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -50, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(goToWebsite(sender:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return btn
    }()
    
    @objc func goToWebsite(sender: UIButton){
        guard let url = URL(string: sender.title(for: .normal)!)  else {return}
        delegate?.goToWebSite(sender: sender, url: url)
    }
    
    fileprivate func setupViews(isWebsite: Bool) {
        backgroundColor = .clear
        addSubview(iconImgView)
        iconImgView.anchor(top: nil, bottom: nil, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 18, height: 25)
        iconImgView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: iconImgView.centerYAnchor).isActive = true
        titleLabel.anchor(top: topAnchor, bottom: bottomAnchor, left: iconImgView.rightAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 130, height: 0)
        
        
        
        if isWebsite{
            addSubview(websiteButton)
            websiteButton.anchor(top: titleLabel.topAnchor, bottom: titleLabel.bottomAnchor, left: titleLabel.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 0, height: 0)
        }else{
            addSubview(subTitleLabel)
            subTitleLabel.anchor(top: titleLabel.topAnchor, bottom: titleLabel.bottomAnchor, left: titleLabel.rightAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 0, height: 0)
        }
        
    }
}
