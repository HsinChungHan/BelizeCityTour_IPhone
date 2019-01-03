//
//  ICDFIntroductionViewController.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/29.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class ICDFIntroductionViewController: UIViewController {
    fileprivate let paragraphsIntroduction = ICDFIntrodutionParagraph.getAllParagraphs()

    lazy var tableView: ICDFTableView = {
        let tv = ICDFTableView.init(paragraphs: paragraphsIntroduction)
        tv.backgroundColor = UIColor.backgroundRiceColor
        tv.separatorStyle = .none
        let blankView = UIView(frame: .zero)
        tv.tableFooterView = blankView
        tv.headerView.delegate = self
        return tv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.fullAnchor(superView: self.view)
        
    }
}


extension ICDFIntroductionViewController: TableHeaderViewDelegate{
    func goToICDFWebsite(sender: UIImageView) {
        guard let url = URL(string: "http://www.icdf.org.tw/mp.asp?mp=2") else {return}
        let naviVC = UINavigationController(rootViewController: WebViewController(url: url))
        present(naviVC, animated: true, completion: nil)
    }
    
    func goToCultureWebsite(sender: UIImageView) {
        guard let url = URL(string: "http://tourism.gov.bz") else {return}
        let naviVC = UINavigationController(rootViewController: WebViewController(url: url))
        present(naviVC, animated: true, completion: nil)
    }
}
