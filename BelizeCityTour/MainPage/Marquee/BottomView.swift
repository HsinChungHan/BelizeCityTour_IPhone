//
//  BottomView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol BottomViewDelegate {
    func tapDetailButton(sender: UIButton, bottomView: UIView, place: Place)
}


class BottomView: UIView {
    var bottomViewDelegate: BottomViewDelegate?
    var place: Place
    
    init(place: Place) {
        self.place = place
        super.init(frame: .zero)
        titleLabe.text = place.englishName
        subTitleLabel.text = place.openingTime
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var detailButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "more")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(goToDetail(sender:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func goToDetail(sender: UIButton){
        bottomViewDelegate?.tapDetailButton(sender: sender, bottomView: self, place: place)
        //        removeTimer()
//        guard let senderTage = senderTag else {return}
//        goToDetailVCDelegate?.goToDetailVC(senderTag: senderTage)
    }
    
    let nameImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "location")
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    
    let timeImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "time")
        imv.contentMode = .scaleAspectFit
        return imv
    }()
    
    lazy var titleLabe: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.backgroundRiceColor
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "MC Hot Dog"
        label.textAlignment = .left
        return label
    }()
    
    
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.backgroundRiceColor
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Mon-Sunday(Open all day)"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func setupViews() {
        backgroundColor = UIColor.classicDarkGreen.withAlphaComponent(0.7)
        setUI()
    }
}

extension BottomView{
    fileprivate func setUI(){
        addSubview(detailButton)
        detailButton.anchor(top: nil, bottom: bottomAnchor, left: nil, right: rightAnchor, topPadding: 0, bottomPadding: 20, leftPadding: 0, rightPadding: -10, width: 120, height: 40)
        addSubview(nameImgView)
        nameImgView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 20, height: 20)
        addSubview(timeImgView)
        timeImgView.anchor(top: nameImgView.bottomAnchor, bottom: bottomAnchor, left: nameImgView.leftAnchor, right: nameImgView.rightAnchor, topPadding: 10, bottomPadding: 35, leftPadding: 0, rightPadding: 0, width: 0, height: 20)
        
        addSubview(titleLabe)
        
        titleLabe.anchor(top: nameImgView.topAnchor, bottom: nil, left: nameImgView.rightAnchor, right: rightAnchor, topPadding: -5, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 0, height: 30)
        addSubview(subTitleLabel)
        subTitleLabel.anchor(top: timeImgView.topAnchor, bottom: nil, left: titleLabe.leftAnchor, right: titleLabe.rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 30)
    }
}
