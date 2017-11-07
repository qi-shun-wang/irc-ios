//
//  TipsViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class TipsViewController: UIViewController {
    
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    var viewModel:TipsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = TipsViewModel(view: self)
        }
        viewModel?.setupNavigationTitle()
    }
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        
        if viewModel == nil {
            viewModel = TipsViewModel(view: self)
        }
        viewModel?.openMenu()
    }
    
}
extension TipsViewController: TipsViewControllerProtocol {
    func openMenu() {
        slideMenuController()?.openLeft()
    }
    func renderNavigationTitle(with text: String) {
        self.navigationItem.title = text
    }
}


