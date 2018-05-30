//
//  BaseContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol BaseView: class {
    // TODO: Declare view methods
    func showLoading()
    func hideLoading()
    func showError(_ message: String?)
    func showMessage(_ message: String?, withTitle title: String?)
    func openMenu()
    func openQRScanner()
    func setupNavigationBarStyle()
    func setupNavigationLeftItem(image named: String, title text: String)
    func setupNavigationRightItem(image named: String, title text: String)
    
    func openDeviceDiscovery()
    //warning badge
    func setupWarningBadge()
    func showWarningBadge(with text:String)
    func hideWarningBadge(with text:String)
}

protocol BasePresentation: class {
    func viewDidLoad()
    func viewWillDisappear()
    func viewWillAppear()
}

