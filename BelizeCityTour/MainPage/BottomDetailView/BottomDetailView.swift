//
//  BottomUpView.swift
//  BelizeCityTour
//
//  Created by Chung Han Hsin on 2019/1/14.
//  Copyright © 2019 辛忠翰. All rights reserved.
//

import UIKit
protocol BottomDetailViewProtocol {
    func goToDetailPage(destinationVC: UIViewController, bottomUpView: BottomDetailView, sender: UIButton)
    func scrollDown(sender: UIButton)
}

class BottomDetailView: UIView {
    var bottomDetailViewDelegate: BottomDetailViewProtocol?
    var bottomDetailViewMaximizedTopAnchor: NSLayoutConstraint?
    var bottomDetailViewMinimizedTopAnchor: NSLayoutConstraint?
    
    
    fileprivate var place: Place!{
        didSet{
            informationView.setupPlace(place: place)
            placeImageView.place = place
        }
    }
    
    public func setupPlace(place: Place){
        self.place = place
    }
    
    var isMinimized = true
    
    lazy var scrollDownbutton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "btn_extend").withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.clear
        btn.addTarget(self, action: #selector(scrollDown(sender:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func scrollDown(sender: UIButton){
        bottomDetailViewDelegate?.scrollDown(sender: sender)
    }
    
    let informationView: BottomView
    var placeImageView: PopInformationView
    
    lazy var visitButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Visit", for: .normal)
        btn.setTitleColor(UIColor.darkBrownText, for: .normal)
        btn.backgroundColor = UIColor.lightSkinBackgroundColor.withAlphaComponent(0.8)
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(goToDetail(sender:)), for: .touchUpInside)
        btn.layer.cornerRadius = 10.0
        btn.clipsToBounds = true
        return btn
    }()
    
    @objc func goToDetail(sender: UIButton){
        let detailVC = DetailViewController.init(place: place)
        let naviVC = UINavigationController.init(rootViewController: detailVC)
        naviVC.isNavigationBarHidden = true
        bottomDetailViewDelegate?.goToDetailPage(destinationVC: naviVC, bottomUpView: self, sender: sender)
    }
    
    init(place: Place) {
        self.place = place
        informationView = BottomView.init(place: place)
        placeImageView = PopInformationView.init(place: place)
        super.init(frame: .zero)
        informationView.detailButton.removeFromSuperview()
        backgroundColor = UIColor.skinBackgroundColor.withAlphaComponent(0.8)
        layer.cornerRadius = 10.0
        clipsToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupViews(){
        let padding = frame.height/8/4
        let stackView = UIStackView.init(arrangedSubviews: [scrollDownbutton, visitButton, informationView, placeImageView])
        stackView.axis = .vertical
        stackView.spacing = padding
        addSubview(stackView)
        stackView.fullAnchor(superView: self, topPadding: 10, bottomPadding: 10, leftPadding: 10, rightPadding: 10)
//        stackView.isLayoutMarginsRelativeArrangement = true //加這行會自動抓到tabBar的位置
//        stackView.layoutMargins = .init(top: 0, left: 10, bottom: 10, right: 10)
        scrollDownbutton.translatesAutoresizingMaskIntoConstraints = false
        scrollDownbutton.heightAnchor.constraint(equalToConstant: padding).isActive = true
        visitButton.translatesAutoresizingMaskIntoConstraints = false
        visitButton.heightAnchor.constraint(equalToConstant: frame.height/10).isActive = true
        informationView.translatesAutoresizingMaskIntoConstraints = false
        informationView.heightAnchor.constraint(equalToConstant: frame.height * 2/10).isActive = true
        informationView.layoutIfNeeded()
        informationView.setupViews()
    }
    
    
    public func configureBottomDetailView(superView: UIView, height: CGFloat){
        setBottomDetailViewBeginningAnchor(superView: superView, height: height)
//        bottomDetailViewMinimizedTopAnchor = topAnchor.constraint(equalTo: mainTabBar!.topAnchor, constant: -mainTabBar!.frame.height - 25)
        bottomDetailViewMinimizedTopAnchor = topAnchor.constraint(equalTo: superView.bottomAnchor, constant: -mainTabBar!.frame.height*2 - 25)
        bottomDetailViewMinimizedTopAnchor?.isActive = true
        bottomDetailViewMaximizedTopAnchor = topAnchor.constraint(equalTo: superView.centerYAnchor, constant: 0)

    }
    
    fileprivate func setBottomDetailViewBeginningAnchor(superView: UIView, height: CGFloat){
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: 10).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -10).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    public func minimizedContainerView(completionHandler:() -> ()){
        isMinimized = true
        bottomDetailViewMaximizedTopAnchor?.isActive = false
        bottomDetailViewMinimizedTopAnchor?.isActive = true
        scrollDownbutton.setImage(#imageLiteral(resourceName: "btn_extend").withRenderingMode(.alwaysOriginal), for: .normal)
        completionHandler()
    }
    
    public func maximizedContainerView(completionHandler:() -> ()){
        isMinimized = false
        bottomDetailViewMinimizedTopAnchor?.isActive = false
        bottomDetailViewMaximizedTopAnchor?.isActive = true
        scrollDownbutton.setImage(#imageLiteral(resourceName: "btn_collapse").withRenderingMode(.alwaysOriginal), for: .normal)
        completionHandler()
    }
    
}
