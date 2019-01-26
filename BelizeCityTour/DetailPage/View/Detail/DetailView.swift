//
//  DetailView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

protocol DetailViewDelegate {
    func dismiss(detailView: UIView, sender: UIButton)
}

class DetailView: UIView {
    var delegate: DetailViewDelegate?
    var place: Place
    init(place: Place) {
        self.place = place
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var dismissButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: IconsConstant.back.rawValue)?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.contentMode = .scaleAspectFit
        btn.addTarget(self, action: #selector(dismissDetailVC(sender:)), for: .touchUpInside)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 40)
        return btn
    }()
    
    @objc func dismissDetailVC(sender: UIButton){
        delegate?.dismiss(detailView: self, sender: sender)
    }
    
    lazy var tableView: DetailTableView = {
        let tv = DetailTableView.init(place: place)
        tv.backgroundColor = UIColor.backgroundRiceColor
        tv.separatorStyle = .none
        let blankView = UIView(frame: .zero)
        tv.tableFooterView = blankView
        return tv
    }()
    
    fileprivate func setupViews(){
        addSubview(tableView)
        tableView.fullAnchor(superView: self)
        
        addSubview(dismissButton)
        dismissButton.anchor(top: topAnchor, bottom: nil, left: leftAnchor, right: nil, topPadding: 0, bottomPadding: 0, leftPadding: 10, rightPadding: 0, width: 60, height: 60)
    }
}



