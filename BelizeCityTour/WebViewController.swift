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
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .gray
        return spinner
    }()
    
    init(url: URL) {
        super.init(nibName: nil, bundle: nil)
        webView.loadRequest(URLRequest(url: url))
        AppDelegate.backgroundMusicPlayer?.pause()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        webView.delegate = self
        view.addSubview(webView)
        webView.fullAnchor(superView: view)
        setupLeftNavigationItemByTitle(title: "Back", selector: #selector(dismissVC))
        view.addSubview(spinner)
        spinner.centerAnchor(superView: view, width: UIScreen.main.bounds.width/6, height: UIScreen.main.bounds.width/6)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true){
            AppDelegate.backgroundMusicPlayer?.play()
        }
        
    }
}

extension WebViewController: UIWebViewDelegate{
    func webViewDidStartLoad(_ webView: UIWebView) {
        spinner.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        spinner.stopAnimating()
    }
}
