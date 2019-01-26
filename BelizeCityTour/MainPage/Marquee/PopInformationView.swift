//
//  PopInformationView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class PopInformationView: BasicView {
    var place: Place{
        didSet{
            var imgs = [UIImage]()
            for imgStr in place.imgs{
                imgs.append(UIImage(named: imgStr)!)
            }
            scrollingView.setupValue(imgs: imgs)
        }
    }
//    var senderTag: Int
//    var bottomView: BottomView
    init(place: Place){
        self.place = place
//        self.senderTag = tag
//        self.bottomView = BottomView.init(place: place)
        super.init(frame: .zero)
        var imgs = [UIImage]()
        for imgStr in place.imgs{
            imgs.append(UIImage(named: imgStr)!)
        }
        scrollingView.setupValue(imgs: imgs)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var scrollingView: ScrollingView = {
       let sv = ScrollingView.init(cellClass: BannerCell.self, cellId: "BannerCellId")
        return sv
    }()
    
    override func setupViews() {
        setupUI()
    }
}

extension PopInformationView{
    
    fileprivate func setupUI(){
        addSubview(scrollingView)
        scrollingView.fullAnchor(superView: self)
        scrollingView.layoutIfNeeded()
        
//        addSubview(bottomView)
//        bottomView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 100)
    }
}
