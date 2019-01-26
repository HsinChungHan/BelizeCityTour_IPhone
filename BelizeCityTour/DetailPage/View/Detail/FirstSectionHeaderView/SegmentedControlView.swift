//
//  SegmentedControlView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol SegmentedControlViewDelegate {
    func changeCurrentValue(segmentContolView: SegmentedControlView,isStory: Bool)
}


class SegmentedControlView: UIView {
    var delegate: SegmentedControlViewDelegate?
    
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        for (index, title) in titles.enumerated(){
            segmentedControl.insertSegment(withTitle: title, at: index, animated: true)
        }
        setupSegmentedControlView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.selectedSegmentIndex = 0
        sc.backgroundColor = .clear
        sc.tintColor = .clear
        sc.setTitleTextAttributes([
            NSAttributedString.Key.font :UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.textBrownColor
            ], for: .normal)
        sc.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20),
            NSAttributedString.Key.foregroundColor: UIColor.darkOrange.withAlphaComponent(0.6)
            ], for: .selected)
        sc.addTarget(self, action: #selector(segmentedContolValueChanged), for: .valueChanged)
        return sc
    }()
    
    @objc func segmentedContolValueChanged(){
        UIView.animate(withDuration: 0.3) {
            self.buttonBar.frame.origin.x = (self.segmentedControl.frame.width / CGFloat(self.segmentedControl.numberOfSegments)) * CGFloat(self.segmentedControl.selectedSegmentIndex)
        }

        delegate?.changeCurrentValue(segmentContolView: self, isStory: segmentedControl.selectedSegmentIndex == 0)
    }
    
    
    let buttonBar: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkOrange
        view.layer.cornerRadius = 3.0
        view.clipsToBounds = true
        view.alpha = 0.6
        return view
    }()
    
    fileprivate func setupSegmentedControlView() {
        addSubview(segmentedControl)
        addSubview(buttonBar)
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.anchor(top: topAnchor, bottom: bottomAnchor, left: leftAnchor, right: rightAnchor, topPadding: 10, bottomPadding: 10, leftPadding: 0, rightPadding: 0, width: 0, height: 0)
        segmentedControl.layoutIfNeeded()
        
        segmentedControl.layer.borderWidth = 1.0
        segmentedControl.layer.borderColor = UIColor.textBrownColor.cgColor
        segmentedControl.layer.cornerRadius = 3.0
        segmentedControl.clipsToBounds = true
        
        buttonBar.bottomAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        // Constrain the button bar to the left side of the segmented control
        buttonBar.leftAnchor.constraint(equalTo: segmentedControl.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: segmentedControl.widthAnchor, multiplier: 1 / CGFloat(segmentedControl.numberOfSegments)).isActive = true
    }
}
