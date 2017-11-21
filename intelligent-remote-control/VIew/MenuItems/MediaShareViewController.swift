//
//  MediaShareViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class MediaShareViewController: BaseViewController {
    
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    
    override func viewDidLoad() {
        viewModel = MediaShareViewModel(view: self)
        super.viewDidLoad()
    }
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        viewModel?.openMenu()
    }
    
}

extension MediaShareViewController: MediaShareViewControllerProtocol {}
