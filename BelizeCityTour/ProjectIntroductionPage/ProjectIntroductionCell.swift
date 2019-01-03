//
//  ProjectIntroductionCell.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ProjectIntroductionCell: UICollectionViewCell {
    var projectIntroduction: ProjectIntroduction?{
        didSet{
//            paragraphLabel.text = projectIntroduction?.paragrapText
//            paragraphLabel.heightAnchor.constraint(equalToConstant: paragraphLabel.getLabelHegit(str: (projectIntroduction?.paragrapText)!, font: paragraphLabel.font, width: paragraphLabel.frame.width) + 300).isActive = true
//            paragraphLabel.setLineSpacing(str: (projectIntroduction?.paragrapText)!, spacing: 10)
//            paragraphLabel.insetEdge = UIEdgeInsets(top: 0, left: 70, bottom: 0, right: 70)
            paragraphTextView.text = projectIntroduction?.paragraphText
            
        }
    }
    
    
    let paragraphTextView: UITextView = {
       let tv = UITextView()
        tv.font = UIFont.init(name: "Centaur", size: 30)
        tv.textColor = .white
        tv.isEditable = false
        tv.textAlignment = .left
        tv.backgroundColor = UIColor.rgb(red: 54, green: 46, blue: 43).withAlphaComponent(0.8)
        tv.textContainerInset = UIEdgeInsets(top: 20, left: 70, bottom: 0, right: 70)
        return tv
    }()
    
    let paragraphLabel: CustomLabel = {
        let label = CustomLabel()
        label.font = UIFont.init(name: "Centaur", size: 30)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.rgb(red: 54, green: 46, blue: 43).withAlphaComponent(0.8)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews(){
        addSubview(paragraphTextView)
        paragraphTextView.fullAnchor(superView: self)
        paragraphTextView.setCorner(radius: 30)
//        addSubview(paragraphLabel)
//        paragraphLabel.centerAnchor(superView: self, width: frame.width - 40, height: 0)
//        paragraphLabel.setCorner(radius: 30)
    }
    
    public func setupValue(projectIntroduction: ProjectIntroduction){
        self.projectIntroduction = projectIntroduction
    }
}
