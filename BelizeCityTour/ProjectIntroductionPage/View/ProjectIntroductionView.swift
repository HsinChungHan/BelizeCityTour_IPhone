//
//  ProjectIntroductionView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit
protocol ProjectIntroductionViewDelegate {
    func goToWebsite(sender: UIButton, destinationNavivc: UINavigationController)
    func goToHOCVideo(sender: UIButton, url: URL)
}

class ProjectIntroductionView: UIView {
    var delegate: ProjectIntroductionViewDelegate?
    let backgroundImgView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        imv.clipsToBounds = true
        return imv
    }()
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        var i = 0
        for family: String in UIFont.familyNames {
            print("\(i)---项目字体---\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family) {
                print("== \(names)")
            }
            i += 1
        }
        label.font = UIFont(name: "VinerHandITC", size: 35)
        label.textColor = UIColor.rgb(red: 32, green: 21, blue: 6)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.backgroundColor = .clear
        return label
    }()
    
    lazy var lastPageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(goToLastCell(sender:)), for: .touchUpInside)
        btn.setImage(UIImage(named: "btn_back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        btn.alpha = 0.0
        return btn
    }()
    
    @objc func goToLastCell(sender: UIButton){
        collectionView.scrollToLastCell()
    }
    
    lazy var nextPageButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(goToNextCell(sender:)), for: .touchUpInside)
        btn.setImage(UIImage(named: "btn_next")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    @objc func goToNextCell(sender: UIButton){
        collectionView.scrollToNextCell()
    }
    
    lazy var hocButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(goToHOCWebsite(sender:)), for: .touchUpInside)
        btn.setImage(UIImage(named: "hocLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit

        return btn
    }()
    
    @objc func goToHOCWebsite(sender: UIButton){
        guard let url = URL(string: "http://tourism.gov.bz/hoc-project/") else {return}
        let naviVC = UINavigationController(rootViewController: WebViewController.init(url: url))
        delegate?.goToWebsite(sender: sender, destinationNavivc: naviVC)
    }
    
    
    lazy var cultureButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(goToCultureWebsite(sender:)), for: .touchUpInside)
        btn.setImage(UIImage(named: "cultureLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    @objc func goToCultureWebsite(sender: UIButton){
        guard let url = URL(string: "http://tourism.gov.bz") else {return}
        let naviVC = UINavigationController(rootViewController: WebViewController.init(url: url))
        delegate?.goToWebsite(sender: sender, destinationNavivc: naviVC)
    }
    
    lazy var ICDFButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.addTarget(self, action: #selector(goToICDFWebsite(sender:)), for: .touchUpInside)
        btn.setImage(UIImage(named: "ICDFShortLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    @objc func goToICDFWebsite(sender: UIButton){
        guard let url = URL(string: "http://www.icdf.org.tw/mp.asp?mp=2") else {return}
        let naviVC = UINavigationController(rootViewController: WebViewController.init(url: url))
        delegate?.goToWebsite(sender: sender, destinationNavivc: naviVC)
    }
    
    let collectionView = ProjectCollectionView()
    
    fileprivate func setupViews() {
        collectionView.projectCollectionViewDelegate = self
        backgroundColor = UIColor.backgroundRiceColor.withAlphaComponent(0.7)
        addSubview(backgroundImgView)
        backgroundImgView.fullAnchor(superView: self)
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, bottom: nil, left: nil, right: nil, topPadding: 40, bottomPadding: 0, leftPadding: 0, rightPadding: 0, width: UIScreen.main.bounds.width * 3 / 4, height: UIScreen.main.bounds.height/10)
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.setCorner(radius: 15)
        titleLabel.adjustsFontSizeToFitWidth = true
        
        addSubview(collectionView)
        print("Height: ", UIScreen.main.bounds.height)
        print("Width: ", UIScreen.main.bounds.width)
        collectionView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        collectionView.anchor(top: nil, bottom: nil, left: leftAnchor, right: rightAnchor, topPadding: 20, bottomPadding: 0, leftPadding: 10, rightPadding: 10, width: 0, height: UIScreen.main.bounds.height*3/5)
        
        
        let stackView = UIStackView()
        stackView.setupStackView(views: [cultureButton, hocButton, ICDFButton], axis: .horizontal, distribution: .fillEqually, spacing: 10)
        addSubview(stackView)
        stackView.anchor(top: collectionView.bottomAnchor, bottom: bottomAnchor, left: collectionView.leftAnchor, right: collectionView.rightAnchor, topPadding: 10, bottomPadding: (mainTabBar?.frame.height)! + 30, leftPadding: 0, rightPadding: 0, width: 0, height: 0)

        
        addSubview(lastPageButton)
        lastPageButton.anchor(top: nil, bottom: nil, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 30, rightPadding: 0, width: 50, height: 50)
        lastPageButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addSubview(nextPageButton)
        nextPageButton.anchor(top: nil, bottom: nil, left: nil, right: rightAnchor, topPadding: 0, bottomPadding: 0, leftPadding: 0, rightPadding: 30, width: 50, height: 50)
        nextPageButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    init(projectIntroduction: ProjectIntroduction) {
        super.init(frame: .zero)
        setupViews()
        backgroundImgView.image = projectIntroduction.image
        titleLabel.text = projectIntroduction.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension ProjectIntroductionView: ProjectCollectionViewDelegate{
    func goToHOCVideo(sender: UIButton, url: URL) {
        delegate?.goToHOCVideo(sender: sender, url: url)
    }
    
    func showProjectIntroductionView(projectIntroduction: ProjectIntroduction, currentIndex: IndexPath, projectIntroductions: [ProjectIntroduction]) {
        UIView.animate(withDuration: 2.0, animations: {[weak self] in
            self?.titleLabel.alpha = 0.1
            self?.backgroundImgView.alpha = 0.1
            
            if currentIndex.item == 0{
                self?.lastPageButton.alpha = 0.0
            }else if currentIndex.item == projectIntroductions.count - 1{
                self?.nextPageButton.alpha = 0.0
            }else{
                self?.lastPageButton.alpha = 1.0
                self?.nextPageButton.alpha = 1.0
            }
            
        }) { (_) in
            UIView.animate(withDuration: 2.0, animations: {[weak self] in
                self?.titleLabel.text = projectIntroduction.title
                self?.backgroundImgView.image = projectIntroduction.image
                self?.titleLabel.alpha = 1.0
                self?.backgroundImgView.alpha = 1.0
                
            })
        }
        
        
    }
}
