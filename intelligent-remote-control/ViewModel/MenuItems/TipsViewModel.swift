//
//  TipsViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
class TipsViewModel: NSObject {
    
    weak var view:TipsViewControllerProtocol?
    
    init(view:TipsViewControllerProtocol) {
        self.view = view
    }
    
    func openMenu() {
        view?.openMenu()
    }
    
    func setupNavigationTitle(){
        view?.setupNavigationTitle(text: "操作使用提示")
    }
}

