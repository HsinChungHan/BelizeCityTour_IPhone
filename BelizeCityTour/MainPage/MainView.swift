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
}

class MainView: BasicView {
    var delegate: MainViewDelegate?
    let places = Place.getPlaces()
    var allPlaceButtons = [Int:(UIButton, Place)]()
    var currentTag: Int?
    
    lazy var backgroundImgView: UIImageView = {
        let imv = UIImageView()
        imv.image = UIImage(named: "ShowRd")
        imv.contentMode = .scaleAspectFill
        imv.isUserInteractionEnabled = true
        imv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissPopView)))
        return imv
    }()
    
    lazy var personImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Guides")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    @objc func dismissPopView(){
        currentPlaceButton?.scaleAnimationRepeated(scaleX: 1.0, scaleY: 1.0)
        currentPopInformationView?.removeFromSuperview()
        currentPlaceButton = nil
        currentPopInformationView = nil
        
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
    
    var currentPopInformationView: PopInformationView?
    var currentPlaceButton: PlaceButton?
    
    public func setupPersonImageView() {
        personImgView.frame = CGRect(x: UIScreen.main.bounds.width - 100, y: 40, width: 80, height: 80)
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
        setupGoToCardButton()
        setupPersonImageView()
    }
    
    fileprivate func setupGoToCardButton(){
        addSubview(goToCardVCButton)
        goToCardVCButton.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil
            , topPadding: 20, bottomPadding: 0, leftPadding: 20, rightPadding: 0, width: 80, height: 80)
    }
}


extension MainView: PlaceButtonDelegate{
    func buttonTap(sender: PlaceButton, place: Place) {
        currentPopInformationView?.removeFromSuperview()
        if let currentTag = currentTag{
            allPlaceButtons[currentTag]!.0.scaleAnimationNoRepeated(scaleX: 1.0, scaleY: 1.0)
//            if currentTag != sender.tag{
//                currentPlaceButton?.isEnabled = true
//            }
        }
        
        sender.scaleAnimationNoRepeated(scaleX: 1.5, scaleY: 1.5)
        UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        let dummyView = UIView(frame: UIScreen.main.bounds)
        dummyView.backgroundColor = .clear
        addSubview(dummyView)
        
        var offset: (offsetX: CGFloat, offsetY: CGFloat) = (0,0)
        switch sender.tag {
        case 0, 3, 12, 10:
            offset = PersonLocation.upper.location(frameWidth: 135, frameHeight: 135)
        case 1, 8, 4, 11, 6:
            offset = PersonLocation.lower.location(frameWidth: 135, frameHeight: 135)
        case 5, 9, 7:
            offset = PersonLocation.righter.location(frameWidth: 135, frameHeight: 135)
        default:
            break
        }
        
        personImgView.movAnimation(endView: sender, duration: 2.0, offsetX: offset.offsetX, offSetY: offset.offsetY) {[weak self] in
            self?.currentPopInformationView = PopInformationView(place: (self?.allPlaceButtons[sender.tag]!.1)!, tag: sender.tag)
            self?.currentPopInformationView!.bottomView.bottomViewDelegate = self
            var arrowOrientation: UIImage.Orientation
            var currentInformationViewTopAnchor: NSLayoutYAxisAnchor? = nil
            var currentInformationViewBottomAnchor: NSLayoutYAxisAnchor? = nil
            switch sender.tag{
            case 0, 3, 5, 9, 10, 12:
                currentInformationViewTopAnchor = nil
                currentInformationViewBottomAnchor = self!.personImgView.topAnchor
                arrowOrientation = .down
            default:
                currentInformationViewTopAnchor = self!.personImgView.bottomAnchor
                currentInformationViewBottomAnchor = nil
                arrowOrientation = .up
            }
            self?.addSubview((self?.currentPopInformationView)!)
            self?.currentPopInformationView!.anchor(top: currentInformationViewTopAnchor, bottom: currentInformationViewBottomAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: 400, height: 400)
            self?.currentPopInformationView!.setCorner(radius: 20)
            self?.currentPopInformationView!.centerXAnchor.constraint(equalTo: (self?.personImgView.centerXAnchor)!, constant: 60).isActive = true
            self?.currentPopInformationView!.layoutIfNeeded()
            self?.currentPopInformationView!.applyArrowDialogAppearanceWithOrientation(frame: (self?.currentPopInformationView!.bounds)!, arrowOrientation: arrowOrientation)
            dummyView.removeFromSuperview()
        }
        
        currentTag = sender.tag
        currentPlaceButton = sender
//        currentPlaceButton?.isEnabled = false
    }
}


extension MainView: BottomViewDelegate{
    func tapDetailButton(sender: UIButton, bottomView: UIView, place: Place) {
        delegate?.tapDetailButton(sender: sender, bottomView: bottomView, place: place)

    }
}
