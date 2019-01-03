//
//  ICDFTableView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/29.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

enum ICDFTableViewCellId: String {
    case textOnly = "TextOnlyTableViewCell"
    case textAndImg = "TextAndImageTableViewCell"
}


class ICDFTableView: UITableView {
    var paragraphs: [ICDFIntrodutionParagraph]
    var headerView = TableHeaderView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 140))
    init(paragraphs: [ICDFIntrodutionParagraph]) {
        self.paragraphs = paragraphs
        super.init(frame: .zero, style: .plain)
        delegate = self
        dataSource = self
        registerCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func registerCell() {
        register(TextOnlyTableViewCell.self, forCellReuseIdentifier: ICDFTableViewCellId.textOnly.rawValue)
        register(TextAndImageTableViewCell.self, forCellReuseIdentifier: ICDFTableViewCellId.textAndImg.rawValue)
    }
}

extension ICDFTableView: UITableViewDelegate, UITableViewDataSource{
    override var numberOfSections: Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.item {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: ICDFTableViewCellId.textOnly.rawValue, for: indexPath) as! TextOnlyTableViewCell
            cell.setupValue(paragraphText: paragraphs[indexPath.item].paragraphText, upperBGColor: paragraphs[indexPath.item].upperBackgroundColor, lowerBGColor: paragraphs[indexPath.item].lowerBackgroundColor)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: ICDFTableViewCellId.textAndImg.rawValue, for: indexPath) as! TextAndImageTableViewCell
            let values = (paragraphs[indexPath.item].upperImgColor, paragraphs[indexPath.item].lowerImgColor, paragraphs[indexPath.item].image, paragraphs[indexPath.item].paragraphText)
            cell.setupValue(values: values)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item {
        case 0: return 800
        default: return 1200
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return headerView
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }
    
}
