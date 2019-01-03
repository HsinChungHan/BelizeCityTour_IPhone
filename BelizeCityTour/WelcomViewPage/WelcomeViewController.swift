//
//  WelcomeViewController.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/22.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import AVFoundation

class WelcomeViewController: UIViewController{
    var timer = Timer()
    var player = AVPlayer()

    lazy var skipButtonView: SkipButtonView = {
       let view = SkipButtonView()
        view.delegate = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSkipButtonView()
        setupPlayerView()
    }

    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

}

extension WelcomeViewController{
    fileprivate func setupSkipButtonView(){
        view.addSubview(skipButtonView)
        skipButtonView.anchor(top: nil, bottom: view.bottomAnchor, left: nil, right: view.rightAnchor, topPadding: 0, bottomPadding: 20, leftPadding: 0, rightPadding: 20, width: 150, height: 50)
    }

    fileprivate func setupPlayerView(){
        let videoURL = Media.introVideo.choosedUrl
        player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 800)
        view.layer.addSublayer(playerLayer)
        player.play()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(moviePlayBackFinished),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: nil)
    }

    @objc func moviePlayBackFinished(){
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(goToMainViewController), userInfo: nil, repeats: false)
    }


    @objc func goToMainViewController(){
        let naviVC = UINavigationController(rootViewController: MainTabBarController())
        naviVC.isNavigationBarHidden = true
        present(naviVC, animated: true) {[weak self] in
            self?.timer.invalidate()
           
        }
    }
}

extension WelcomeViewController: SkipButtonDelegate{
    func goToMainVC(from view: SkipButtonView, to naviVC: UINavigationController) {
        naviVC.isNavigationBarHidden = true
        present(naviVC, animated: true){[weak self] in
            self?.timer.invalidate()
        }
    }
}





