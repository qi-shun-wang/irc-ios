//
//  MediaShareViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MediaShareViewModel: NSObject {
    
    weak var view: MediaShareViewControllerProtocol?
    
    init(view: MediaShareViewControllerProtocol) {
        self.view = view
    }
    
    func openMenu() {
        view?.openMenu()
    }
    
    func setupNavigationTitle(){
        view?.renderNavigationTitle(with: "媒體分享")
    }
}
