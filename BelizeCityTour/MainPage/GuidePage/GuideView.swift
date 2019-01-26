//
//  GuideView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2019/1/2.
//  Copyright © 2019 辛忠翰. All rights reserved.
//

import UIKit

protocol GuideViewDelegate {
    func goToDetail(sender: UIButton, detailNaviVC: UINavigationController, guideView: GuideView)
}

class GuideView: UIView {

    let place = Place.getPlaces()[12]
    
    var delegate: GuideViewDelegate?
    
    let firstDiretionView = DirectionView.init(clue: ClueConstant.tapPlaceIcon.rawValue, arrow: .rightDirectionArrow)
    let secondDiretionView = DirectionView.init(clue: ClueConstant.tapMoreToDetailView.rawValue, arrow: .leftDirectionArrow)
    
    
    lazy var personImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "Guides")
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    lazy var placeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(tapPlaceBtn(sender:)), for: .touchUpInside)
        return btn
    }()
    
    @objc func tapPlaceBtn(sender: UIButton){
        sender.scaleAnimationNoRepeated(scaleX: 1.5, scaleY: 1.5)
        UIView.transition(with: sender, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        UIView.animate(withDuration: 1.0, animations: {[weak self]  in
            self?.firstDiretionView.alpha = 0
        }) { [weak self] _ in
            self?.firstDiretionView.removeFromSuperview()
        }
        
        personImgView.movAnimation(endView: sender, duration: 2.0, offsetX: -10, offSetY: -30) {[weak self] in
//            let popInformationView = PopInformationView(place: (self?.place)!, tag: (self?.place.tag)!)
            let popInformationView = PopInformationView(place: (self?.place)!)

//            popInformationView.bottomView.bottomViewDelegate = self
            self?.addSubview(popInformationView)
            popInformationView.anchor(top: nil, bottom: self?.personImgView.topAnchor, left: nil, right: nil, topPadding: 0, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: 400, height: 400)
            popInformationView.setCorner(radius: 20)
            popInformationView.centerXAnchor.constraint(equalTo: (self?.personImgView.centerXAnchor)!, constant: 60).isActive = true
            popInformationView.layoutIfNeeded()
            popInformationView.applyArrowDialogAppearanceWithOrientation(frame: popInformationView.bounds, arrowOrientation: .down)
            
            self?.addSubview((self?.secondDiretionView)!)
            self?.secondDiretionView.anchor(top: popInformationView.bottomAnchor, bottom: self?.bottomAnchor, left: popInformationView.rightAnchor, right: self?.rightAnchor, topPadding: -30, bottomPadding: 50, leftPadding: -80, rightPadding: 10, width: 0, height: 0)
            self?.secondDiretionView.alpha = 0.0
            UIView.animate(withDuration: 1.0, animations: {
                self?.secondDiretionView.alpha = 1.0
            })
        }
    }
    
    init() {
        super.init(frame: .zero)
        placeButton.setImage(UIImage(named: place.iconImg)?.withRenderingMode(.alwaysOriginal), for: .normal)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        let blackView = UIView()
        blackView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        addSubview(blackView)
        blackView.fullAnchor(superView: self)
        
        addSubview(placeButton)
        placeButton.frame = CGRect(x: place.iconLocation.x, y: place.iconLocation.y, width: 140, height: 140)
        
        addSubview(personImgView)
        personImgView.frame = CGRect(x: UIScreen.main.bounds.width - 100, y: 40, width: 80, height: 80)
        
        addSubview(firstDiretionView)
        firstDiretionView.anchor(top: nil, bottom: bottomAnchor, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 40, leftPadding: 40, rightPadding: 0, width: 200, height: 300)
    }

}


extension GuideView: BottomViewDelegate{
    func tapDetailButton(sender: UIButton, bottomView: UIView, place: Place) {
        let naviVC = UINavigationController(rootViewController: DetailViewController.init(place: place))
        naviVC.isNavigationBarHidden = true
        delegate?.goToDetail(sender: sender, detailNaviVC: naviVC, guideView: self)
    }
    
    
}
