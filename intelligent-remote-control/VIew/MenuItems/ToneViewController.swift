//
//  ToneViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class ToneViewController: UIViewController {
    
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    var viewModel:ToneViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = ToneViewModel(view: self)
        }
        viewModel?.setupNavigationTitle()
    }
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        
        if viewModel == nil {
            viewModel = ToneViewModel(view: self)
        }
        viewModel?.openMenu()
    }
    
}
extension ToneViewController: ToneViewControllerProtocol {
    func openMenu() {
        slideMenuController()?.openLeft()
    }
    func renderNavigationTitle(with text: String) {
        self.navigationItem.title = text
    }
}



