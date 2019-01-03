//
//  BasicTableViewCell.swift
//  BelizeCulture
//
//  Created by 辛忠翰 on 2018/8/2.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class BasicTableViewCell: UITableViewCell {
    var place: Place?{
        didSet{
            
        }
    }
    
    
    func setupViews(){
        
    }

    func setupValues(place: Place) {
        self.place = place
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
