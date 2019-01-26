//
//  ProjectCollectionView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol ProjectCollectionViewDelegate {
    func showProjectIntroductionView(projectIntroduction: ProjectIntroduction, currentIndex: IndexPath, projectIntroductions: [ProjectIntroduction])
    func goToHOCVideo(sender: UIButton, url: URL)
}

enum ProjectCollectionViewArgument: String{
    case projectCellId = "projectCellId"
}


class ProjectCollectionView: UICollectionView {
    let projectIntroductions = ProjectIntroduction.getAllIntroductions()
    var currentIndexPath = IndexPath.init(item: 0, section: 0)
    var projectCollectionViewDelegate: ProjectCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        isScrollEnabled = false
        delegate = self
        dataSource = self
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        backgroundColor = .clear
        register(ProjectIntroductionCell.self, forCellWithReuseIdentifier: ProjectCollectionViewArgument.projectCellId.rawValue)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProjectCollectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProjectCollectionViewArgument.projectCellId.rawValue, for: indexPath) as! ProjectIntroductionCell
        
        cell.setupValue(projectIntroduction: projectIntroductions[indexPath.item])
        cell.paragraphTextView.isSelectable = false
        if indexPath.item == 1{
            cell.setupLinkAttributedText()
        }
        return cell
    }
    
    public func scrollToNextCell(){
        if currentIndexPath.item < projectIntroductions.count - 1{
            currentIndexPath.item += 1
            scrollToItem(at: currentIndexPath, at: .right, animated: true)
            projectCollectionViewDelegate?.showProjectIntroductionView(projectIntroduction: projectIntroductions[currentIndexPath.item], currentIndex: currentIndexPath, projectIntroductions: projectIntroductions)
        }
    }
    
    public func scrollToLastCell(){
        if currentIndexPath.item > 0{
            currentIndexPath.item -= 1
            scrollToItem(at: currentIndexPath, at: .left, animated: true)
            projectCollectionViewDelegate?.showProjectIntroductionView(projectIntroduction: projectIntroductions[currentIndexPath.item], currentIndex: currentIndexPath, projectIntroductions: projectIntroductions)
        }
    }
    
    
}

extension ProjectCollectionView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
