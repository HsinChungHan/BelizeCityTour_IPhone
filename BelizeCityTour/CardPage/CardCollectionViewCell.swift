//
//  CardCollectionViewCell.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2019/1/2.
//  Copyright © 2019 辛忠翰. All rights reserved.
//

import UIKit
protocol LikeButtonDelegate {
    func didLikedButtonPressed(cell: CardCollectionViewCell, completionHandler: (_ isAnimated: Bool) -> ())
}



class CardCollectionViewCell: BasicCell {
    var likedButtonDelegate: LikeButtonDelegate?
    var isLiked: Bool = false{
        didSet{
            if isLiked{
                heartButton.tintColor = UIColor.heartRed
            }else{
                heartButton.tintColor = UIColor.white
            }
        }
    }
    var place: Place?{
        didSet{
            guard let place = place else {return}
            imgView.image = UIImage(named: place.imgs[0])
            titleLabel.text = place.englishName
            subtitleLabel.text = place.openingTime
            isLiked = place.isLiked
        }
    }
    
    let imgView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.classicDarkGreen.withAlphaComponent(0.5)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.classicDarkGreen.withAlphaComponent(0.5)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = UIColor.white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    
    lazy var heartButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(handleLove), for: .touchUpInside)
        btn.imageView?.contentMode = .scaleAspectFill
        btn.imageView?.clipsToBounds = true
        btn.tintColor = UIColor.white
        btn.setImage(UIImage(named: "heartfull")?.withRenderingMode(.alwaysTemplate), for: .normal)
        return btn
    }()
    
    lazy var animationView1: FBStreamingView = {
        let fBSV = FBStreamingView()
        let imgView = UIImageView()
        fBSV.addSubview(imgView)
        imgView.fullAnchor(superView: fBSV)
        imgView.image = UIImage(named: "FBheart")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return fBSV
    }()
    
    lazy var animationView2: FBStreamingView = {
        let fBSV = FBStreamingView()
        let imgView = UIImageView()
        fBSV.addSubview(imgView)
        imgView.fullAnchor(superView: fBSV)
        imgView.image = UIImage(named: "thumbs_up")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return fBSV
    }()
    
    lazy var animationView3: FBStreamingView = {
        let fBSV = FBStreamingView()
        let imgView = UIImageView()
        fBSV.addSubview(imgView)
        imgView.fullAnchor(superView: fBSV)
        imgView.image = UIImage(named: "FBheart")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return fBSV
    }()
    
    lazy var animationView4: FBStreamingView = {
        let fBSV = FBStreamingView()
        let imgView = UIImageView()
        fBSV.addSubview(imgView)
        imgView.fullAnchor(superView: fBSV)
        imgView.image = UIImage(named: "thumbs_up")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return fBSV
    }()
    
    lazy var animationView5: FBStreamingView = {
        let fBSV = FBStreamingView()
        let imgView = UIImageView()
        fBSV.addSubview(imgView)
        imgView.fullAnchor(superView: fBSV)
        imgView.image = UIImage(named: "FBheart")
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return fBSV
    }()
    
    var animationViews: [FBStreamingView]?
    
    @objc func handleLove(sender: UIButton){
        
        likedButtonDelegate?.didLikedButtonPressed(cell: self, completionHandler: {(animated) in
            if animated{
                //                generateAnimatedViews(times: 10)
                
                //                generateAnimatedViews()
                generateAnimatedViews(annimationViews: animationViews!)
            }
        })
    }
    
    override func setupViews() {
        self.backgroundColor = .clear
        setupImgView()
        setupLabels()
        setupHeartButton()
        registerObserver()
        animationViews = [animationView1, animationView2, animationView3, animationView4, animationView5]
        
    }
}

extension CardCollectionViewCell {
    
    fileprivate func setupImgView(){
        addSubview(imgView)
        imgView.fullAnchor(superView: self)
    }
    
    fileprivate func setupLabels(){
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        titleLabel.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 40, bottomPadding: 0, leftPadding: 20, rightPadding: 20, width: 0, height: 30)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, bottom: nil, left: titleLabel.leftAnchor, right: titleLabel.rightAnchor, topPadding: 10, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        
        subtitleLabel.adjustsFontSizeToFitWidth = true
        
        layoutIfNeeded()
        titleLabel.setCorner(radius: 5)
        subtitleLabel.setCorner(radius: 5)
    }
    
    fileprivate func setupHeartButton(){
        addSubview(heartButton)
        heartButton.anchor(top: nil, bottom: bottomAnchor, left: nil, right: rightAnchor, topPadding: 0, bottomPadding: 10, leftPadding: 0, rightPadding: 10, width: 50, height: 50)
    }
    
    fileprivate func generateAnimatedViews(annimationViews: [FBStreamingView]){
        let dimension = 50 + drand48() * 10
        //        animationView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
        //        addSubview(animationView)
        for animationView in annimationViews{
            animationView.frame = CGRect(x: 0, y: 0, width: dimension, height: dimension)
            addSubview(animationView)
        }
    }
    
    fileprivate func registerObserver(){
        NotificationCenter.default.addObserver(self, selector: #selector(removeAnimationView), name: Notification.Name.removeView , object: nil)
    }
    
    @objc func removeAnimationView(){
        //        sender.removeFromSuperview()
        animationView1.removeFromSuperview()
        animationView2.removeFromSuperview()
        animationView3.removeFromSuperview()
        animationView4.removeFromSuperview()
        animationView5.removeFromSuperview()
        
    }
    
}

extension Notification.Name{
    static let removeView = Notification.Name("removeView")
}
