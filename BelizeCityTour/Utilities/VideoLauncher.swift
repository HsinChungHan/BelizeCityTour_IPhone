//
//  VideoLauncher.swift
//  Youtube
//
//  Created by 辛忠翰 on 21/12/17.
//  Copyright © 2017 辛忠翰. All rights reserved.
//

import UIKit
import AVFoundation
class VideoPlayer: UIView {
    //set spinner
    let activityIndicatorView: UIActivityIndicatorView = {
       let aiv = UIActivityIndicatorView()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    let controlsContainerView: UIView = {
       let view = UIView()
        
//        view.backgroundColor = UIColor(white: 0, alpha: 1)
        view.backgroundColor = UIColor.red
        return view
    }()
    
    let pausePlayButton: UIButton = {
       let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "pause"), for: .normal)
        btn.tintColor = .white
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(handlePausePlayButton), for: .touchUpInside)
        btn.isHidden = true
//         btn.isHidden = false
        return btn
    }()
    
    var isPlaying = false
    @objc func handlePausePlayButton() {
        if isPlaying{
            player?.pause()
            pausePlayButton.setImage(UIImage(named: "play"), for: .normal)
        }else{
            player?.play()
            pausePlayButton.setImage(UIImage(named: "pause"), for: .normal)
           
        }
        isPlaying = !isPlaying
        
    }
    
    let beginTimeLabel: UILabel = {
       let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var videoSlider: UISlider = {
       let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    @objc func handleSliderChange(){
        guard let duration = videoDuration else {return}
        let currentSeconds = videoSlider.value * duration
        let seekTime = CMTime(seconds: Double(currentSeconds), preferredTimescale: 1)
        player?.seek(to: seekTime, completionHandler: { (completedSeek) in
            let secondsText = Int(currentSeconds.truncatingRemainder(dividingBy: 60))//seconds%60
            let minutesText2 = String(format:"%02d", Int(currentSeconds)/60)
            self.beginTimeLabel.text = "\(minutesText2):\(secondsText)"
        })
    }
    let endTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupControlsContainerView(frame: CGRect) {
        backgroundColor = .black
        controlsContainerView.frame = frame
        print("controlsContainerView.frame: ", controlsContainerView.frame)
        setupGradientLayer()
        
        
        addSubview(controlsContainerView)
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsContainerView.addSubview(pausePlayButton)
        pausePlayButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        pausePlayButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        pausePlayButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        pausePlayButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsContainerView.addSubview(endTimeLabel)
        endTimeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        endTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        endTimeLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        endTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsContainerView.addSubview(beginTimeLabel)
        beginTimeLabel.centerYAnchor.constraint(equalTo: endTimeLabel.centerYAnchor).isActive = true
        beginTimeLabel.heightAnchor.constraint(equalTo: endTimeLabel.heightAnchor).isActive = true
        beginTimeLabel.widthAnchor.constraint(equalTo: endTimeLabel.widthAnchor).isActive = true
        beginTimeLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        
        controlsContainerView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: endTimeLabel.leftAnchor, constant: -4).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: beginTimeLabel.rightAnchor, constant: 8).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
    
    var player: AVPlayer?
    private func setupPlayerView() {
        //setup AVPlayer
        let urlString = "https://firebasestorage.googleapis.com/v0/b/gameofchats-762ca.appspot.com/o/message_movies%2F12323439-9729-4941-BA07-2BAE970967C7.mov?alt=media&token=3e37a093-3bc8-410f-84d3-38332af9c726"
        guard let url = NSURL(string: urlString) else{return}
        player = AVPlayer(url: url as URL)
        let playerLayer = AVPlayerLayer(player: player)
        self.layer.addSublayer(playerLayer)
        playerLayer.frame = self.frame
        player?.play()
        //setting an observer to the player to know when the movie is already downloaded
        //--currentItem.loadedTimeRanges--可以用來知道何時下載完成
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new , context: nil)
        
        
        //track player progress
        //表示一秒
        let interval = CMTime(value: 1, timescale: 2)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
//            let seconds = progressTime.getSeconds()
            let seconds = progressTime.seconds
            //seconds%60
            let secondsText = String(format:"%02d",Int(seconds.truncatingRemainder(dividingBy: 60)))
            let minutesText = String(format:"%02d", Int(seconds)/60)
            self.beginTimeLabel.text = "\(minutesText):\(secondsText)"
            guard let duration = self.player?.currentItem?.duration else {return}
//            let durationTime = duration.getSeconds()
            let durationTime = duration.seconds
//            self.videoSlider.value = Float(seconds / durationTime)
            self.videoSlider.setValue(Float(seconds / durationTime), animated: true)
        })
    }
    
    var videoDuration: Float?
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //表示影片下載完成
        if keyPath == "currentItem.loadedTimeRanges"{
            //當影片下載完成時，stop spinner
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            pausePlayButton.isHidden = false
            isPlaying = true
            guard let duration = player?.currentItem?.duration else{return}
//            let seconds = duration.getSeconds()
            let seconds = duration.seconds
            let secondsText = Int(seconds.truncatingRemainder(dividingBy: 60))//seconds%60
//            let minutesText = Int(seconds / 60)
            let minutesText2 = String(format:"%02d", Int(seconds)/60)
            endTimeLabel.text = "\(minutesText2):\(secondsText)"
            videoDuration = Float(seconds)
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //讓ＣontrolsContainerView可以覆蓋在PlayerView上
        setupPlayerView()
        print("Video frame: ", frame)
        setupControlsContainerView(frame: frame)
    }
    
    func setupGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        //為了要讓漸層色只出現在slider bar，所以需設定期layer的location
        //0: top, 1: bottom，所以1.2代表超出邊界了
        gradientLayer.locations = [0.7, 1.2]
        controlsContainerView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class VideoLauncher: NSObject {
    func showVideoPlayer() {
        print("Show video player...")
        if let keyWindow = UIApplication.shared.keyWindow{
            let view = UIView(frame: keyWindow.frame)
            view.backgroundColor = .white
            //16 * 9 is the aspect ratio of all HD videos
            let height = view.frame.width * 9 / 16
            let videoPlayer = VideoPlayer(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: height))
            view.addSubview(videoPlayer)
            
            //想要做出動畫的感覺，給view begin frame和final frame
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            keyWindow.addSubview(view)
            //做出動畫感
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
                print("view.frame: ", view.frame )
                print("keyWindow.frame: ", keyWindow.frame )
            }, completion: { (completedAnimation) in
                //hide status bar
//                UIApplication.shared.setStatusBarHidden(true, with: .fade)
                UIApplication.shared.isStatusBarHidden = true
                
            })
        }
    }
}
