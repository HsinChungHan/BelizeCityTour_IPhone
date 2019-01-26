//
//  MainViewController.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/26.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    lazy var mainView: MainView = {
        let mainView = MainView()
        mainView.delegate = self
        return mainView
    }()
    
    lazy var guideView: GuideView = {
       let gv = GuideView()
        gv.delegate = self
        return gv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
//        view.addSubview(guideView)
//        guideView.fullAnchor(superView: view)
    }

}

extension MainViewController{
    fileprivate func setupMainView(){
        view.addSubview(mainView)
        mainView.fullAnchor(superView: view)
    }
}

extension MainViewController: MainViewDelegate{
    func goToDetailPage(destinationVC: UIViewController, bottomUpView: BottomDetailView, sender: UIButton) {
        present(destinationVC, animated: true, completion: nil)
    }
    
    func goToCard(sender: UIButton, destinationNaviVC: UINavigationController) {
        present(destinationNaviVC, animated: true, completion: nil)
    }
    
    func tapDetailButton(sender: UIButton, bottomView: UIView, place: Place) {
        let naviVC = UINavigationController(rootViewController: DetailViewController.init(place: place))
        naviVC.isNavigationBarHidden = true
        present(naviVC, animated: true, completion: nil)
    }
    
    
}

extension MainViewController: GuideViewDelegate{
    func goToDetail(sender: UIButton, detailNaviVC: UINavigationController, guideView: GuideView) {
        present(detailNaviVC, animated: true) {[weak self] in
            guideView.removeFromSuperview()
            self?.mainView.setupPersonImageView()
        }
    }
    
    
}















public enum PersonImageViewLocation: Int{
    case Johns = 12
    case HOC = 0
    case EuseyHouse = 10
    case CockburnLaneHouse = 3
    case Court = 1
    case MulePark = 8
    case PaslowPlaza = 4
    case BelizeWelcomeSign = 11
    case BattlefieldPark = 6
    case Yarborough = 5
    case WesleyChurch = 9
    case SwingBridge = 7
    
    func location(frameWidth: CGFloat, frameHeight: CGFloat) -> (offsetX: CGFloat, offsetY: CGFloat){
        switch self {
        case .HOC, .Johns, .EuseyHouse, .CockburnLaneHouse:
            return (0,0)
        case .Court, .MulePark, .PaslowPlaza, .BelizeWelcomeSign, .BattlefieldPark:
            return (-30, frameHeight - 80)
        case .Yarborough, .WesleyChurch, .SwingBridge:
            return (frameWidth - 60, 30)
        }
    }
}


public enum PersonLocation{
    case upper
    case lower
    case righter
    
    func location(frameWidth: CGFloat, frameHeight: CGFloat) -> (offsetX: CGFloat, offsetY: CGFloat){
        switch self {
        case .upper:
            return (60,60)
        case .lower:
            return (40, frameHeight - 20)
        case .righter:
            return (frameWidth - 30, 30)
        }
    }
}

