//
//  BasePresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class BasePresenter {
    
    // MARK: Properties
    
    weak var view: BaseView?
    
}

extension BasePresenter: BasePresentation {
   
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.setupNavigationLeftItem(image: "radio_icon", title: "尚未連接到設備")
        view?.setupNavigationRightItem(image: "qr_code_scan_icon", title: "")
        view?.setupNavigationBarStyle()
    }
    
}

