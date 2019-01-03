//
//  DetailViewController.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2018/12/28.
//  Copyright © 2018 辛忠翰. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var place: Place
    var detailView: DetailView
    
    init(place: Place) {
        self.place = place
        detailView = DetailView.init(place: place)
        super.init(nibName: nil, bundle: nil)
        detailView.tableView.detailTableViewDelegate = self
        detailView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        detailView.fullAnchor(superView: view)
    }

    
}

extension DetailViewController: DetailTableViewDelegate{
    
    func goToMapViewController(detailTableView: UITableView, to viewController: UINavigationController) {
        present(viewController, animated: true)
    }
    
}

extension DetailViewController: DetailViewDelegate{
    func dismiss(detailView: UIView, sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
