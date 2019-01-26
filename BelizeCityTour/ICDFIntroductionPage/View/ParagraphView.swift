//
//  ParagraphImageView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/29.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol ParagraphViewDelegate {
    func goToICDFVideo(sender: UIImageView)
}

class ParagraphView: UIView {
    var delegate: ParagraphViewDelegate?
    
    init(upperColor: UIColor, lowerColor: UIColor, image: UIImage) {
        super.init(frame: .zero)
        upperView.backgroundColor = upperColor
        lowerView.backgroundColor = lowerColor
        imgView.image = image
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let upperView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appleGreenBackgroundColor
        return view
    }()
    
    fileprivate let lowerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    fileprivate let imgView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    fileprivate func setupViews(){
        addSubview(upperView)
        upperView.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: ICDFINtroductionConstant.ParagraphImageViewHeight.rawValue/2)
        
        addSubview(lowerView)
        lowerView.anchor(top: upperView.bottomAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        addSubview(imgView)
        imgView.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 20, bottomPadding: 20, leftPadding: 20, rightPadding: 20, width: 0, height: 0)
    }
    
    public func loadGIF(name: String){
        imgView.loadGif(name: name)
        imgView.isUserInteractionEnabled = true
        imgView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(goToICDFVideo(sender:))))
    }
    
     @objc func goToICDFVideo(sender: UIImageView){
        delegate?.goToICDFVideo(sender: sender)
    }
}
