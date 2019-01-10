//
//  DetailTableView.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

enum CellId: String, CaseIterable{
    case storyCell = "StoryCellId"
    case informtionCell = "InformationCellId"
    case mapCell = "MapCellId"
}

protocol DetailTableViewDelegate {
    func goToMapViewController(detailTableView: UITableView, to viewController: UINavigationController)
}

class DetailTableView: UITableView {
    var detailTableViewDelegate: DetailTableViewDelegate?
    var place: Place
    var isStory = true
    //    var tapWebsite = false
    let tableBackgroundImgView: UIImageView = {
        let imv = UIImageView()
        imv.contentMode = .scaleAspectFill
        return imv
    }()
    
    var firstSectionHeaderView: FirstSectionHeaderView
    
    init(place: Place) {
        self.place = place
        self.firstSectionHeaderView = FirstSectionHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 20), place: place)
        super.init(frame: .zero, style: .plain)
        registerCells()
        delegate = self
        dataSource = self
        setupTableViewBackgroundView(backGroundViewHeight: HeightConstant.plcacImgView.rawValue)
        firstSectionHeaderView.segmentedControlView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupTableViewBackgroundView(backGroundViewHeight: CGFloat){
        self.tableBackgroundImgView.image = UIImage(named: place.imgs[0])
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: backGroundViewHeight))
        backgroundView?.addSubview(tableBackgroundImgView)
        tableBackgroundImgView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: backGroundViewHeight)
        let dummyView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: backGroundViewHeight + 20))
        dummyView.backgroundColor = .clear
        tableHeaderView = dummyView
    }
    
    fileprivate func registerCells() {
        register(StoryTableViewCell.self, forCellReuseIdentifier: CellId.storyCell.rawValue)
        register(InformationTableViewCell.self, forCellReuseIdentifier: CellId.informtionCell.rawValue)
        register(MapTableViewCell.self, forCellReuseIdentifier: CellId.mapCell.rawValue)
    }
}


extension DetailTableView: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch isStory {
        case true: return 1
        case false: return 2
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 1{
            let mapVC = MapViewController()
            mapVC.setupValues(place: place)
            let naviVC = UINavigationController(rootViewController: mapVC)
            naviVC.isNavigationBarHidden = true
            detailTableViewDelegate?.goToMapViewController(detailTableView: self, to: naviVC)
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellId: String
        switch isStory {
        case true:
            cellId = CellId.storyCell.rawValue
        case false:
            if indexPath.item == 0{
                cellId = CellId.informtionCell.rawValue
            }else{
                cellId = CellId.mapCell.rawValue
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BasicTableViewCell
        cell.setupValues(place: place)
        //        if let cell = cell as? InformationTableViewCell{
        //            ((cell.informationViews[4]) as? InformationView)?.delegate = self
        //        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch isStory {
        case true: return 1030
        case false:
            if indexPath.item == 0{
                //                if tapWebsite{
                //                    return 320 + 500
                //                }
                return 280
                
            }else{
                return 550
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0{
            return firstSectionHeaderView
        }
        return nil
    }
    
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        firstSectionHeaderView.backgroundColor = UIColor.classicDarkGreen.withAlphaComponent(offsetY/HeightConstant.plcacImgView.rawValue)
        if offsetY < 0{
            tableBackgroundImgView.frame.size = CGSize(width: UIScreen.main.bounds.width - offsetY, height: HeightConstant.plcacImgView.rawValue - offsetY)
        }
    }
    
}


extension DetailTableView: SegmentedControlViewDelegate{
    func changeCurrentValue(segmentContolView: SegmentedControlView, isStory: Bool) {
        self.isStory = isStory
        reloadData()
    }
    
    
}

//
//extension DetailTableView: InformationViewDelegate{
//    func goToWebSite(sender: UIButton, url: URL) {
//        switch isStory {
//        case false:
//            tapWebsite = true
//            let indexPath = IndexPath(item: 0, section: 0)
//            reloadRows(at: [indexPath], with: .fade)
//            let cell = cellForRow(at: indexPath) as! InformationTableViewCell
//            cell.setupWebView(url: url)
//        default:
//            tapWebsite = false
//        }
//    }
//}
