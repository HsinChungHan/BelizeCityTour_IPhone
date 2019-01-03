//
//  BannerCell.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/27.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import Foundation
import UIKit

class BannerCell: BasicCell {
//    fileprivate var image: UIImage? {
//        didSet{
//            imageView.image = image
//        }
//    }
//
//    public func setupValue(image: UIImage){
//        self.image = image
//    }
    
    subscript (image: UIImage) -> (){
        imageView.image = image
    }
    
    let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    internal override func setupViews() {
        addSubview(imageView)
        imageView.fullAnchor(superView: self)
    }
}

