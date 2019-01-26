//
//  InformationTableViewCell.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

enum TitleName: String, CaseIterable {
    case type = "Type"
    case location = "Location"
    case phone = "Phone"
    case time = "Time"
    case website = "Website"
}

enum ImgName: String, CaseIterable{
    case time = "time"
    case location = "location"
    case ninja = "ninja"
    case type = "Type"
    case Phone = "Phone"
    case Website = "Website"
}



class InformationTableViewCell: BasicTableViewCell {
    var informationViews = [UIView]()
    let webView = UIWebView()
    
    override var place: Place?{
        didSet{
            guard let place = place else {return}
            setInformationView(place: place)
        }
    }
    
    fileprivate func setInformationView(place: Place){
        selectionStyle = .none
        webView.backgroundColor = UIColor.backgroundRiceColor
        var lastView: UIView?
        var topAnchor: NSLayoutYAxisAnchor
        var bottomAnchor: NSLayoutYAxisAnchor?
        var height: CGFloat = 50
        informationViews = [
            InformationView.init(image: UIImage(named: ImgName.time.rawValue)!, title: TitleName.time.rawValue, subTitle: place.openingTime, isWebsite: false),
            InformationView.init(image: UIImage(named: ImgName.type.rawValue)!, title: TitleName.type.rawValue, subTitle: place.type, isWebsite: false),
            InformationView.init(image: UIImage(named: ImgName.location.rawValue)!, title: TitleName.location.rawValue, subTitle: place.address, isWebsite: false),
            InformationView.init(image: UIImage(named: ImgName.Phone.rawValue)!, title: TitleName.phone.rawValue, subTitle: place.phone, isWebsite: false),
            //            InformationView.init(image: UIImage(named: ImgName.Website.rawValue)!, title: TitleName.website.rawValue, subTitle: place.website, isWebsite: true),
            //            webView
        ]
        
        for (index,view) in informationViews.enumerated(){
            addSubview(view)
            if let lastView = lastView{topAnchor = lastView.bottomAnchor
            }else{topAnchor = self.topAnchor}
            
            //            if index == informationViews.count - 1{
            //                bottomAnchor = nil
            //                height = 0
            //            }
            
            view.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: height)
            lastView = view
        }
    }
    
    //    public func setupWebView(url: URL){
    //        webView.loadRequest(URLRequest(url: url))
    //        webView.layoutIfNeeded()
    //        webView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    //    }
    
    
}

