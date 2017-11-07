//
//  ToneViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class ToneViewModel: NSObject {
    
    weak var view: ToneViewControllerProtocol?
    
    init(view: ToneViewControllerProtocol) {
        self.view = view
    }
    
    func openMenu() {
        view?.openMenu()
    }
    
    func setupNavigationTitle(){
        view?.renderNavigationTitle(with: "定調助手")
    }
}

