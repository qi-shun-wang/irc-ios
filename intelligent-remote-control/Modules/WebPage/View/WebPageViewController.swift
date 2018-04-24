//
//  WebPageViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/24.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebPageViewController: BaseViewController, StoryboardLoadable,WKUIDelegate{
    
    // MARK: Properties
    
    var webView: WKWebView!
    var presenter: WebPagePresentation?
    
    // MARK: Lifecycle
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = .black
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {}
    
    @objc func dismissPage(){
        navigationController?.dismiss(animated: true)
    }
    
    
    override func setupNavigationRightItem(image named: String, title text: String) {
        let close = UIBarButtonItem(title: "關閉", style: .plain, target: self, action: #selector(dismissPage))
        navigationItem.rightBarButtonItem = close
        navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
}

extension WebPageViewController: WebPageView {
    func setupWeb(url: String) {
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
    // TODO: implement view output methods
}
