//
//  WebViewController.swift
//  BelizeCityTour
//
//  Created by 辛忠翰 on 2019/1/1.
//  Copyright © 2019 辛忠翰. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    let webView = UIWebView()
    
    init(url: URL) {
        super.init(nibName: nil, bundle: nil)
        webView.loadRequest(URLRequest(url: url))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.addSubview(webView)
        webView.fullAnchor(superView: view)
        setupLeftNavigationItemByTitle(title: "Back", selector: #selector(dismissVC))
    }
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
}
