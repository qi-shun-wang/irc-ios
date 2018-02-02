//
//  KaraokeViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class KaraokeViewController: BaseViewController, StoryboardLoadable {

     var webView: WKWebView!
    
    // MARK: Properties
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    var presenter: KaraokePresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let myURL = URL(string: "https://sim.ising99.com/ising99")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

extension KaraokeViewController: KaraokeView {
    // TODO: implement view output methods
}

extension KaraokeViewController:WKUIDelegate{
    
}
