//
//  MainTabBarController.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/22.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
var mainTabBar: UITabBar? = nil
class MainTabBarController: UITabBarController, TabBarControllerDelegate{
//    override var prefersStatusBarHidden: Bool {
//        return true
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .brown
        mainTabBar = tabBar
        setupViewControllers()
//        setImagePosition(tabBar: tabBar, top: 6, left: 0, bottom: -6, right: 0)
//        setTitlePosition(tabBar: tabBar, horizontal: -10, vertical: 10)
    }
}


extension MainTabBarController{
    fileprivate func setupViewControllers(){
        let naviVC0 = templateNaviViewController(rootViewController: MainViewController(), unselectedImage: "main_unselected", selectedImage: "main", title: "Map")
        let naviVC1 = templateNaviViewController(rootViewController: ProjectIntroductionViewController(), unselectedImage: "project_unselected", selectedImage: "project", title: "Project")
        let naviVC2 = templateNaviViewController(rootViewController: ICDFIntroductionViewController(), unselectedImage: "about_unselected", selectedImage: "about", title: "About us")
        
        viewControllers = [naviVC0, naviVC1, naviVC2]
    }
}
