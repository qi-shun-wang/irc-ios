//
//  BaseViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class BaseViewModel: NSObject {
    
    weak var view: BaseViewControllerProtocol?
    lazy var title:String = "Base"
    
    init(view: BaseViewControllerProtocol) {
        self.view = view
    }
    
    func openMenu() {
        view?.openMenu()
    }
    
    func setupNavigationTitle(){
        view?.renderNavigationTitle(with: title)
    }
    
    func setupNavigationBarBackground(){
        view?.renderNavigationBarBackgroundImage(named: "navi_bg")
    }
    
    func setupNavigationLeftItemIcon(){
        view?.renderNavigationItemIcon(named: "menu_icon")
    }

}
