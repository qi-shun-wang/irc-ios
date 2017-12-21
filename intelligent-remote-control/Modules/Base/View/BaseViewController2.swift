//
//  BaseViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class BaseViewController2: UIViewController, BaseView {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationLeftItem(image: "radio_icon", title: " 已連結到 KOD iSing99-00")
        setupNavigationRightItem(image: "qr_code_scan_icon", title: "")
        setupNavigationBarStyle()
    }
    func setupNavigationLeftItem(image named: String, title text: String) {
        let button = UIButton()
        button.setImage(UIImage(named: named), for: .normal)
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func setupNavigationRightItem(image named: String, title text: String) {
        let buttonR = UIButton()
        buttonR.sizeToFit()
        buttonR.setImage(UIImage(named: named), for: .normal)
        buttonR.addTarget(self, action: #selector(openQRScanner), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonR)
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showError(_ message: String?) {
        
    }
    
    func showMessage(_ message: String?, withTitle title: String?) {
        
    }
    @objc func openMenu() {
        slideMenuController()?.openLeft()
    }
    @objc func openQRScanner() {
        print("open QR Scanner")
    }
    
    func setupNavigationBarStyle() {
        let bar = navigationController?.navigationBar
        bar?.barTintColor = UIColor(named:"main_background_color")
        bar?.isTranslucent = false
        
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
        
        
    }
}
