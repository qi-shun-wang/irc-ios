//
//  BaseViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var navigationBarBackground:UIImageView = UIImageView()
    var viewModel:BaseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewModel == nil {
            viewModel = BaseViewModel(view: self)
        }
        
        viewModel?.viewDidLoad()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.viewModel?.setupRotatingNavigationBarBackground()
        }) { (context) in
            self.viewModel?.setupRotatedNavigationBarBackground()
        }
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
            navigationBarBackground.frame = backgroundFrame
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
    func rotatedNavigationBarBackgroundImage() {
        let bar = navigationController?.navigationBar
        if let backgroundFrame = bar?.realNavigationBarFrame() {
            navigationBarBackground.frame = backgroundFrame
        }
    }
    
    func rotatingNavigationBarBackgroundImage(){
        navigationBarBackground.frame = CGRect.zero
    }
}
