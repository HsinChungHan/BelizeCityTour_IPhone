//
//  MainView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol MainViewDelegate {
    func tapDetailButton(sender: UIButton, bottomView: UIView, place: Place)
    func goToCard(sender: UIButton, destinationNaviVC: UINavigationController)
    func goToDetailPage(destinationVC: UIViewController, bottomUpView: BottomDetailView, sender: UIButton)
}

class MainView: BasicView {
    var delegate: MainViewDelegate?
    let places = Place.getPlaces()
    var allPlaceButtons = [Int:(UIButton, Place)]()
    var currentTag: Int?
    
    var bottomDetailView: BottomDetailView
    
    init() {
        bottomDetailView = BottomDetailView.init(place: places[0])
        super.init(frame: .zero)
        bottomDetailView.bottomDetailViewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var backgroundImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "ShowRd")
        imv.contentMode = .scaleAspectFill
        imv.isUserInteractionEnabled = true
        imv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(scrollBottomDetailView)))
        return imv
    }()
    
    lazy var personImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Guides")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    fileprivate func maximizedView() {
        if bottomDetailView.isMinimized{
            bottomDetailView.maximizedContainerView {
                UIView.animate(withDuration: 0.5, animations: {
                    self.layoutIfNeeded()
                    mainTabBar!.transform = CGAffineTransform.init(translationX: 0, y: 200)
                }, completion: nil)
            }
        }
    }
    
    fileprivate func maximizedAndMinimizedView() {
        if bottomDetailView.isMinimized{
            bottomDetailView.maximizedContainerView {
                UIView.animate(withDuration: 0.5, animations: {
                    self.layoutIfNeeded()
                    mainTabBar!.transform = CGAffineTransform.init(translationX: 0, y: 200)
                }, completion: nil)
            }
        }else{
            bottomDetailView.minimizedContainerView {
                UIView.animate(withDuration: 0.5, animations: {
                    self.layoutIfNeeded()
                    mainTabBar!.transform = .identity
                }, completion: nil)
            }
        }
    }
    
    @objc func scrollBottomDetailView(){
        maximizedAndMinimizedView()
    }
    
    lazy var goToCardVCButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: IconsConstant.DisplayMode.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(goToCardVC(sender:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func goToCardVC(sender: UIButton){
        let naviVC = UINavigationController(rootViewController: CardViewController())
        naviVC.isNavigationBarHidden = true
        delegate?.goToCard(sender: sender, destinationNaviVC: naviVC)
    }
    
    var currentPlaceButton: PlaceButton?
    
    public func setupPersonImageView() {
        personImgView.frame = CGRect(x: UIScreen.main.bounds.width - 50, y: 40, width: 40, height: 40)
        addSubview(personImgView)
    }
    
    override func setupViews() {
        addSubview(backgroundImgView)
        backgroundImgView.fullAnchor(superView: self)
        
        var subviews = [UIView]()
        for place in places{
            let placeBtn = PlaceButton(index: place.tag, place: place)
            allPlaceButtons[placeBtn.tag] = (placeBtn, place)
            subviews.append(placeBtn)
            placeBtn.delegate = self
        }
        
        for view in subviews{addSubview(view)}
        setupPersonImageView()
        insertSubview(bottomDetailView, belowSubview: mainTabBar!)
        bottomDetailView.configureBottomDetailView(superView: self, height: UIScreen.main.bounds.height/2)
        bottomDetailView.layoutIfNeeded()
        bottomDetailView.setupViews()
    }
    
    fileprivate func setupGoToCardButton(){
        addSubview(goToCardVCButton)
        goToCardVCButton.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil
            , topPadding: 20, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: 40, height: 40)
    }
}


extension MainView: PlaceButtonDelegate{
    func buttonTap(sender: PlaceButton, place: Place) {
        bottomDetailView.setupPlace(place: place)
        if let currentTag = currentTag{
            allPlaceButtons[currentTag]!.0.scaleAnimationNoRepeated(scaleX: 1.0, scaleY: 1.0)
        }
        
        sender.scaleAnimationNoRepeated(scaleX: 1.5, scaleY: 1.5)
        UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        let dummyView = UIView(frame: UIScreen.main.bounds)
        dummyView.backgroundColor = .clear
        addSubview(dummyView)
        
        var offset: (offsetX: CGFloat, offsetY: CGFloat) = (0,0)
        switch sender.tag {
        case 0, 3, 12, 10:
            offset = PersonLocation.upper.location(frameWidth: 65, frameHeight: 65)
        case 1, 8, 4, 11, 6:
            offset = PersonLocation.lower.location(frameWidth: 65, frameHeight: 65)
        case 5, 9, 7:
            offset = PersonLocation.righter.location(frameWidth: 65, frameHeight: 65)
        default:
            break
        }
        
        personImgView.movAnimation(endView: sender, duration: 2.0, offsetX: offset.offsetX, offSetY: offset.offsetY) {[weak self] in
            self?.maximizedView()
            dummyView.removeFromSuperview()
        }
        
        currentTag = sender.tag
        currentPlaceButton = sender
    }
}


extension MainView: BottomViewDelegate{
    func tapDetailButton(sender: UIButton, bottomView: UIView, place: Place) {
        delegate?.tapDetailButton(sender: sender, bottomView: bottomView, place: place)
    }
}

extension MainView: BottomDetailViewProtocol{
    func scrollDown(sender: UIButton) {
        maximizedAndMinimizedView()
    }
    func goToDetailPage(destinationVC: UIViewController, bottomUpView: BottomDetailView, sender: UIButton) {
        delegate?.goToDetailPage(destinationVC: destinationVC, bottomUpView: bottomUpView, sender: sender)
    }
}
