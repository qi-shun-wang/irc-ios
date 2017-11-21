//
//  BaseViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var viewModel:BaseViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = BaseViewModel(view: self)
        }
        viewModel?.setupNavigationTitle()
        viewModel?.setupNavigationBarBackground()
        viewModel?.setupNavigationLeftItemIcon()
    }
}

extension BaseViewController: BaseViewControllerProtocol {
    @objc func openMenu() {
        slideMenuController()?.openLeft()
    }
    func renderNavigationTitle(with text: String) {
        let bar = navigationController?.navigationBar
        
        bar?.titleTextAttributes = [
            NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20),
            NSAttributedStringKey.foregroundColor: UIColor.white]
        
        navigationItem.title = text
    }
    
    func renderNavigationBarBackgroundImage(named filename: String) {
        let bar = navigationController?.navigationBar
        if let backgroundFrame = bar?.realNavigationBarFrame() {
            let navigationBarBackground = UIImageView(frame: backgroundFrame)
            navigationBarBackground.image = UIImage(named: filename)
            navigationBarBackground.contentMode = .scaleToFill
            view.addSubview(navigationBarBackground)
        }
        bar?.transparentNavigationBar()
    }
    func renderNavigationItemIcon(named filename: String) {
        let button = UIButton()
        button.setImage(UIImage(named: filename), for: .normal)
        button.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        
    }
}
