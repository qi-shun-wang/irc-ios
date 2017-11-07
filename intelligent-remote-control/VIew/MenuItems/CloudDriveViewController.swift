//
//  CloudDriveViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class CloudDriveViewController: UIViewController {
    
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    var viewModel:CloudDriveViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = CloudDriveViewModel(view: self)
        }
        viewModel?.setupNavigationTitle()
    }
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        
        if viewModel == nil {
            viewModel = CloudDriveViewModel(view: self)
        }
        viewModel?.openMenu()
    }
    
}
extension CloudDriveViewController: CloudDriveViewControllerProtocol {
    func openMenu() {
        slideMenuController()?.openLeft()
    }
    func renderNavigationTitle(with text: String) {
        self.navigationItem.title = text
    }
}

