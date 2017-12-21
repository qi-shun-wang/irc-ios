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
    
    func setupViewBackgroundColor(named: String) {
        view.backgroundColor = UIColor(named:named)
    }
    func renderNavigationTitle(with text: String) {
        let bar = navigationController?.navigationBar
        bar?.barTintColor = UIColor(named:"main_background_color")
        bar?.isTranslucent = false
        bar?.titleTextAttributes = [
            NSAttributedStringKey.font:UIFont.systemFont(ofSize: 20),
            NSAttributedStringKey.foregroundColor: UIColor.white]
        
        let underlineFrame = CGRect(
            origin: CGPoint(
                x: bar!.frame.origin.x,
                y: bar!.frame.size.height - 1),
            size: CGSize(
                width: bar!.bounds.width,
                height: 1
            )
        )
        let underline = UIView(frame:underlineFrame)
        
        underline.backgroundColor = UIColor(white: 1, alpha: 0.2)
        bar?.addSubview(underline)
        navigationItem.title = text
        
    }
    
    //    func renderNavigationBarBackgroundImage(named filename: String) {
    //        let bar = navigationController?.navigationBar
    //        if let backgroundFrame = bar?.realNavigationBarFrame() {
    //            navigationBarBackground.frame = backgroundFrame
    //            navigationBarBackground.image = UIImage(named: filename)
    //            navigationBarBackground.contentMode = .scaleToFill
    //            view.addSubview(navigationBarBackground)
    //        }
    //        bar?.transparentNavigationBar()
    //    }
    
    @objc func openQRScanner() {
        print("open QR Scanner")
    }
    func renderNavigationItemIcon(named filename: String) {
        let button = UIButton()
        button.setImage(UIImage(named: filename), for: .normal)
        button.setTitle(" 已連結到 KOD iSing99-00", for: .normal)
        button.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        let buttonR = UIButton()
        buttonR.sizeToFit()
        buttonR.setImage(UIImage(named: "qr_code_scan_icon"), for: .normal)
        buttonR.addTarget(self, action: #selector(openQRScanner), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonR)
        
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
