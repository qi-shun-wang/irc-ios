//
//  BaseViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseView {
    
    var badge: WarningBadge = WarningBadge()
    func setupWarningBadge() {
        let toViewFrame = CGRect(x: 0, y: 64 - 40, width: UIScreen.main.bounds.width, height: 40)
        badge.frame = toViewFrame
        view.addSubview(badge)
    }
    
    @objc func openDeviceDiscovery() {
        
    }
    
    func hideWarningBadge(with text: String) {
        badge.text = text
        let nvBarH = navigationController?.navigationBar.frame.height ?? 0
        let options = UIViewAnimationOptions.curveEaseIn
        let finalCenter = CGPoint(x:  UIScreen.main.bounds.width / 2, y: nvBarH + badge.frame.height)
        
        UIView.animate(withDuration: 1, delay: 0, options: options, animations: {
            self.badge.backgroundColor = .green
            self.badge.warningText.textColor = .black
        }) { (finished) in
            UIView.animate(withDuration: 5, delay: 1,animations: {
                self.badge.center = CGPoint(x: finalCenter.x, y:finalCenter.y - 100)
            })
        }
    }
    
    func showWarningBadge(with text: String) {
        badge.text = text
        let nvBarH = navigationController?.navigationBar.frame.height ?? 0
        let options = UIViewAnimationOptions.curveEaseIn
        let finalCenter = CGPoint(x:  UIScreen.main.bounds.width / 2, y: nvBarH + badge.frame.height )
        badge.center.y = (nvBarH + badge.frame.height) / 2
        UIView.animate(withDuration: 1, delay: 0, options: options, animations: {
            self.badge.backgroundColor = .red
            self.badge.warningText.textColor = .white
            self.badge.center = finalCenter
        }) { (finished) in
            self.badge.center = finalCenter
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationLeftItem(image: "radio_icon", title: " 已連結到 KOD+ iSing99-00")
        setupNavigationRightItem(image: "qr_code_scan_icon", title: "")
        setupNavigationBarStyle()
    }
    func setupNavigationLeftItem(image named: String, title text: String) {
        let button = UIButton()
        button.setImage(UIImage(named: named), for: .normal)
        button.setTitle(text, for: .normal)
        button.addTarget(self, action: #selector(openDeviceDiscovery), for: .touchUpInside)
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
//        slideMenuController()?.openLeft()
        
    }
    @objc func openQRScanner() {
        print("open QR Scanner")
    }
    
    func setupNavigationBarStyle() {
        guard let bar = navigationController?.navigationBar else {return}
        bar.barTintColor = UIColor(named:"main_background_color")
        bar.isTranslucent = false
        
        let underlineFrame = CGRect(
            origin: CGPoint(
                x: bar.frame.origin.x,
                y: bar.frame.size.height - 1),
            size: CGSize(
                width: bar.bounds.width,
                height: 1
            )
        )
        let underline = UIView(frame:underlineFrame)
        
        underline.backgroundColor = UIColor(white: 1, alpha: 0.2)
        bar.addSubview(underline)
        
        
    }
}
