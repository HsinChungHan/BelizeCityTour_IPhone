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
    fileprivate var place: Place!{
        didSet{
            titleLabe.text = place.englishName
            subTitleLabel.text = place.openingTime
        }
    }
    
    public func setupPlace(place: Place){
        self.place = place
    }
    init(place: Place) {
        self.place = place
        super.init(frame: .zero)
        titleLabe.text = place.englishName
        subTitleLabel.text = place.openingTime
        layer.cornerRadius = 10.0
        clipsToBounds = true
//        setupViews()
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
        label.textColor = UIColor.darkBrownText
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "MC Hot Dog"
        label.textAlignment = .left
        return label
    }()
    
    
    
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightBrownText
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "Mon-Sunday(Open all day)"
        label.textAlignment = .left
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func setupViews() {
        backgroundColor = UIColor.lightSkinBackgroundColor.withAlphaComponent(0.8)
        setUI()
    }
}

extension BottomView{
    fileprivate func setUI(){
        let nameView = UIView()
        let nameStackView = UIStackView.init(arrangedSubviews: [nameImgView, titleLabe])
        nameStackView.axis = .horizontal
        nameImgView.translatesAutoresizingMaskIntoConstraints = false
        nameImgView.widthAnchor.constraint(equalToConstant: frame.height / 6).isActive = true
        nameStackView.spacing = 10
        nameView.addSubview(nameStackView)
        nameStackView.fullAnchor(superView: nameView)

        let timeView = UIView()
        let timeStackView = UIStackView.init(arrangedSubviews: [timeImgView, subTitleLabel])
        timeStackView.axis = .horizontal
        timeImgView.translatesAutoresizingMaskIntoConstraints = false
        timeImgView.widthAnchor.constraint(equalToConstant: frame.height / 6).isActive = true
        timeStackView.spacing = 10
        timeView.addSubview(timeStackView)
        timeStackView.fullAnchor(superView: timeView)
        
        let stackView = UIStackView.init(arrangedSubviews: [nameView, timeView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.fullAnchor(superView: self)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 3, left: 10, bottom: 3, right: 10)
    }
}
