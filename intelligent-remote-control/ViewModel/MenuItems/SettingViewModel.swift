//
//  SettingViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
class SettingViewModel: NSObject {
    
    weak var view:SettingViewControllerProtocol?
    
    init(view:SettingViewControllerProtocol) {
        self.view = view
    }
    
    func openMenu() {
        view?.openMenu()
    }
    
    func setupNavigationTitle(){
        view?.setupNavigationTitle(text: "設定")
    }
}
