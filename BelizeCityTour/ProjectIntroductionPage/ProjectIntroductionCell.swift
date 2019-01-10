//
//  ProjectIntroductionCell.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/31.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol ProjectIntroductionCellDelegate {
    func goToHOCVideo(sender: UIButton, url: URL)
}

class ProjectIntroductionCell: UICollectionViewCell {
    var delegate: ProjectIntroductionCellDelegate?
    var projectIntroduction: ProjectIntroduction?{
        didSet{
            
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
    
    public func setupLinkHOCVideoLink(linkText: String){
        let linkButton = UIButton(type: .system)
        linkButton.setTitle(linkText, for: .normal)
        linkButton.titleLabel?.font = UIFont.init(name: "Centaur", size: 30)
        linkButton.setTitleColor(UIColor.white, for: .normal)
        linkButton.backgroundColor = .clear
        linkButton.addTarget(self, action: #selector(goToHOCVideo(sender:)), for: .touchUpInside)
        addSubview(linkButton)
        linkButton.anchor(top: nil, bottom: paragraphTextView.bottomAnchor, left: paragraphTextView.leftAnchor, right: paragraphTextView.rightAnchor, topPadding: 0, bottomPadding: 40, leftPadding: 0, rightPadding: 0, width: 0, height: 40)
        
    }
    
    @objc func goToHOCVideo(sender: UIButton){
        guard let url = URL(string: "https://www.youtube.com/watch?v=05dlrr3obIE&feature=youtu.be") else {return}
        delegate?.goToHOCVideo(sender: sender, url: url)
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
