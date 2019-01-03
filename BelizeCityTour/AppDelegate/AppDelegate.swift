//
//  AppDelegate.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/22.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
import AVFoundation

enum Media: CaseIterable {
    case backgroundMusic
    case introVideo
    var choosedUrl: URL{
        switch self {
        case .backgroundMusic:
        return createUrl(resourceName: "backgroundMusic", resourceType: .mp3)!
        case .introVideo:
            return createUrl(resourceName: "intro", resourceType: .mp4)!
        }
    }
    
    enum MediaType: String, CaseIterable{
        case mp3
        case mp4
    }
    fileprivate func createUrl(resourceName: String, resourceType: MediaType) -> URL?{
        return URL(fileURLWithPath: Bundle.main.path(forResource: resourceName , ofType: resourceType.rawValue)!)
    }
}

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let musicPathUrl = Media.backgroundMusic.choosedUrl
    var backgroundMusicPlayer: AVAudioPlayer?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupBackgroundMusic()
        window = UIWindow()
        window?.makeKeyAndVisible()
//        window?.rootViewController = ProjectIntroductionViewController()
        window?.rootViewController = WelcomeViewController()
        Thread.sleep(forTimeInterval: 1.5)
        return true
    }

}

extension AppDelegate{
    fileprivate func setupBackgroundMusic(){
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: musicPathUrl)
            backgroundMusicPlayer?.numberOfLoops = Int(MAX_INPUT)
        } catch {
            print("Failed to play music: \(error.localizedDescription)")
        }
        backgroundMusicPlayer?.play()
    }
}
