//
//  WelcomView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/22.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
protocol SkipButtonDelegate{
    func goToMainVC(from view: SkipButtonView, to naviVC: UINavigationController)
}


class SkipButtonView: BasicView {
    var delegate: SkipButtonDelegate?
    
    lazy var skipButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("skip >>", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.addTarget(self, action: #selector(goToMainVC), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        return btn
    }()
    
    @objc func goToMainVC(){
        let naviVC = UINavigationController(rootViewController: MainTabBarController())
        delegate?.goToMainVC(from: self, to: naviVC)
    }
    
    override func setupViews() {
        setupGoToSkipButton()
    }

    
}

extension SkipButtonView{
    fileprivate func setupGoToSkipButton(){
        addSubview(skipButton)
        skipButton.fullAnchor(superView: self)
        skipButton.alpha = 0.0
        UIView.animate(withDuration: 1.0, delay: 4.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.skipButton.alpha = 1.0
        }, completion: nil)
    }
}
