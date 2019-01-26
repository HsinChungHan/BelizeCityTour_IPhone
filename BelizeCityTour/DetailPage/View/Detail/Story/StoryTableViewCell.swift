//
//  StoryTableViewCell.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class StoryTableViewCell: BasicTableViewCell {
    
    override var place: Place? {
        didSet{
            guard let place = place else {return}
            var lastView: StoryInformationView? = nil
            for index in 0 ... 2{
                let viewType: ViewType = .imgMiddle
                let informationView = StoryInformationView.init(viewType: viewType, image: place.imgs[index], text: place.englishStorys[index])
                setupInformationView(lastView: lastView, view: informationView)
                lastView = informationView
            }
        }
    }
    
    override func setupViews() {
        selectionStyle = .none
        backgroundColor = UIColor.backgroundRiceColor
    }
}


extension StoryTableViewCell{
    func setupInformationView(lastView: StoryInformationView?, view: StoryInformationView){
        addSubview(view)
        if let lastView = lastView{
            view.anchor(top: lastView.bottomAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 20, rightPadding: 20, width: 0, height: 500)
        }else{
            view.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 20, rightPadding: 20, width: 0, height: 500)
        }
    }
}
