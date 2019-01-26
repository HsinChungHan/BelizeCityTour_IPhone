//
//  ProjectIntroductionViewController.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/30.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ProjectIntroductionViewController: UIViewController {
    let projectIntroductionView = ProjectIntroductionView.init(projectIntroduction: ProjectIntroduction.getAllIntroductions()[0])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        projectIntroductionView.delegate = self
        view.addSubview(projectIntroductionView)
        projectIntroductionView.fullAnchor(superView: view)   
    }
}

extension ProjectIntroductionViewController: ProjectIntroductionViewDelegate{
    func goToHOCVideo(sender: UIButton, url: URL) {
        let naviVC = UINavigationController.init(rootViewController: WebViewController.init(url: url))
        present(naviVC, animated: true)
    }
    
    func goToWebsite(sender: UIButton, destinationNavivc: UINavigationController) {
        present(destinationNavivc, animated: true, completion: nil)
    }
    
}
