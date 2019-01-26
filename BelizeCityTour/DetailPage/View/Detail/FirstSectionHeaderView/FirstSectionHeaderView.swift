//
//  FirstSectionHeaderView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class FirstSectionHeaderView: UIView {
    var place: Place
    
    init(frame: CGRect, place: Place) {
        
        self.place = place
        super.init(frame: frame)
        
        self.frame = frame
        titleLabel.text = place.englishName
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.text = "M.C Hot Dog"
        label.textAlignment = .center
        return label
    }()
    
    lazy var segmentedControlView: SegmentedControlView = {
        let scv = SegmentedControlView.init(frame: frame, titles: ["Story", "Information"])
        return scv
    }()

    fileprivate func setupViews() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 3/5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.adjustsFontSizeToFitWidth = true
        addSubview(segmentedControlView)
        segmentedControlView.anchor(top: titleLabel.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 5, bottomPadding: 5, leftPadding: 15, rightPadding: 15, width: 0, height: 0)
    }
    
}
