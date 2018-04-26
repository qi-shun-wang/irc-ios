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
    lazy var toViewFrame:CGRect = CGRect(x: 0, y: -topDistance - 40, width: UIScreen.main.bounds.width, height: 40)
    lazy var finalCenter = CGPoint(x:  UIScreen.main.bounds.width / 2, y: (badge.bounds.height)/2 + topDistance )
    
    public var topDistance : CGFloat{
        get{
            if navigationController != nil && !navigationController!.navigationBar.isTranslucent {
                return 0
            }else{
                let barHeight = navigationController?.navigationBar.frame.height ?? 0
                let statusBarHeight = UIApplication.shared.isStatusBarHidden ? CGFloat(0) : UIApplication.shared.statusBarFrame.height
                return barHeight + statusBarHeight
            }
        }
    }
    
    func setupWarningBadge() {
        badge.frame = toViewFrame
        view.addSubview(badge)
    }
    
    @objc func openDeviceDiscovery() {
        
    }
    
    func hideWarningBadge(with text: String) {
        badge.text = text
        let options = UIViewAnimationOptions.curveEaseIn
    
        UIView.animate(withDuration: 1, delay: 0, options: options, animations: {
            self.badge.backgroundColor = .green
            self.badge.warningText.textColor = .black
        }) { (finished) in
            UIView.animate(withDuration: 5, delay: 1,animations: {
                self.badge.center = CGPoint(x: self.toViewFrame.midX, y: self.toViewFrame.midY)
            })
        }
    }
    
    func showWarningBadge(with text: String) {
        badge.text = text
        let options = UIViewAnimationOptions.curveEaseIn
        
        badge.center.y = toViewFrame.midY
        UIView.animate(withDuration: 1, delay: 0, options: options, animations: {
            self.badge.backgroundColor = .red
            self.badge.warningText.textColor = .white
            self.badge.center = self.finalCenter
        }) { (finished) in
            self.badge.center = self.finalCenter
        }
        
    }
    
    let activityView:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationLeftItem(image: "device_disconnect_icon", title: " 尚未連接到設備")
        setupNavigationRightItem(image: "qr_code_scan_icon", title: "")
        setupNavigationBarStyle()
        setupWarningBadge()
        activityView.center = self.view.center
        activityView.color = UIColor(red:141/255.0, green:0/255.0, blue:147/255.0, alpha: 1)
        view.addSubview(activityView)
    }
    
    func setupNavigationLeftItem(image named: String, title text: String) {
        let button = UIButton()
        button.setImage(UIImage(named: named), for: .normal)
        button.setTitle(text, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(openDeviceDiscovery), for: .touchUpInside)
        button.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func setupNavigationRightItem(image named: String, title text: String) {
        let buttonR = UIButton()
        buttonR.sizeToFit()
        buttonR.setImage(UIImage(named: named), for: .normal)
        buttonR.imageView?.contentMode = .scaleAspectFit
        buttonR.addTarget(self, action: #selector(openQRScanner), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: buttonR)
    }
    
    func showLoading() {
//        if activityView.isAnimating {return}
        activityView.startAnimating()
    }
    
    func hideLoading() {
//        if !activityView.isAnimating {return}
        activityView.stopAnimating()
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
        if #available(iOS 11.0, *) {
            bar.barTintColor = UIColor(named:"main_background_color")
        } else {
            // Fallback on earlier versions
            bar.barTintColor = UIColor.main_background_color
        }
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
