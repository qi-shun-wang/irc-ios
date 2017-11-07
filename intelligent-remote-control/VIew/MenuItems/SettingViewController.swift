//
//  SettingViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    var viewModel:SettingViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = SettingViewModel(view: self)
        }
        viewModel?.setupNavigationTitle()
    }
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        
        if viewModel == nil {
            viewModel = SettingViewModel(view: self)
        }
        viewModel?.openMenu()
    }
    
}
extension SettingViewController: SettingViewControllerProtocol {
    func openMenu() {
        slideMenuController()?.openLeft()
    }
    func setupNavigationTitle(text: String) {
        self.navigationItem.title = text
    }
}

