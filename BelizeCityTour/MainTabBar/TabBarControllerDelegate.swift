//
//  TabBarControllerDelegate.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/22.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
public protocol TabBarControllerDelegate {
    mutating func templateNaviViewController(rootViewController: UIViewController, unselectedImage: String, selectedImage: String, title: String) -> UINavigationController
    mutating func setImagePosition(tabBar: UITabBar, top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat)
    mutating func setTitlePosition(tabBar: UITabBar, horizontal: CGFloat, vertical: CGFloat)
}

extension TabBarControllerDelegate{
    func setImagePosition(tabBar: UITabBar, top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat){
        guard let items = tabBar.items else {return}
        for item in items{
            item.imageInsets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        }
    }
    
    func setTitlePosition(tabBar: UITabBar, horizontal: CGFloat, vertical: CGFloat){
        guard let items = tabBar.items else {return}
        for item in items{
            item.titlePositionAdjustment = UIOffset(horizontal: horizontal, vertical: vertical)
        }
    }
    
    
    func templateNaviViewController(rootViewController: UIViewController, unselectedImage: String, selectedImage: String, title: String) -> UINavigationController{
        let naviVC = UINavigationController(rootViewController: rootViewController)
        naviVC.tabBarItem.image = UIImage(named: unselectedImage)?.withRenderingMode(.alwaysOriginal)
        naviVC.tabBarItem.selectedImage = UIImage(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        naviVC.tabBarItem.title = title
        naviVC.isNavigationBarHidden = true
        return naviVC
    }
}
