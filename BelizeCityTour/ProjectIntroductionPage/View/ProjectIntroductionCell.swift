//
//  ProjectIntroductionCell.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ProjectIntroductionCell: UICollectionViewCell {
    public func setupLinkAttributedText() {
        paragraphTextView.isSelectable = true
        let paragraphTextAttributedStr = NSMutableAttributedString.init(string: (projectIntroduction?.paragraphText)!, attributes: [
            NSAttributedString.Key.font : UIFont.init(name: "Centaur", size: 25)!,
            NSAttributedString.Key.foregroundColor: UIColor.white
            ])
        let linkAttributedStr = NSMutableAttributedString.init(string: "  Click here to watch the introduction video!", attributes: [
            NSAttributedString.Key.font : UIFont.init(name: "Centaur", size: 25)!,
            NSAttributedString.Key.foregroundColor : UIColor.lightBlue
            ])
        
        if linkAttributedStr.setAsLink(textToFind: "  Click here to watch the introduction video!", linkURL: "https://www.youtube.com/watch?v=05dlrr3obIE&feature=youtu.be"){
            let attributedText = NSMutableAttributedString()
            attributedText.append(paragraphTextAttributedStr)
            attributedText.append(linkAttributedStr)
            paragraphTextView.attributedText = attributedText
        }
    }
    
    var projectIntroduction: ProjectIntroduction?{
        didSet{
            guard let paragraphText = projectIntroduction?.paragraphText else {return}
            paragraphTextView.text = paragraphText
        }
    }
    
    let paragraphTextView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.init(name: "Centaur", size: 25)
        tv.textColor = .white
        tv.isEditable = false
        tv.textAlignment = .left
        tv.backgroundColor = UIColor.rgb(red: 54, green: 46, blue: 43).withAlphaComponent(0.8)
        tv.textContainerInset = UIEdgeInsets(top: 20, left: 70, bottom: 0, right: 70)
        return tv
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
    }
    
    public func setupValue(projectIntroduction: ProjectIntroduction){
        self.projectIntroduction = projectIntroduction
    }
}


extension NSMutableAttributedString {
    //Just supported UITextView
    // you need to make your UITextView selectable to allow the link to be clickable
    public func setAsLink(textToFind:String, linkURL:String) -> Bool {
        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.addAttribute(.link, value: linkURL, range: foundRange)
            return true
        }
        return false
    }
}
