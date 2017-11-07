//
//  CloudDriveViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class CloudDriveViewModel: NSObject {
    
    weak var view: CloudDriveViewControllerProtocol?
    
    init(view: CloudDriveViewControllerProtocol) {
        self.view = view
    }
    
    func openMenu() {
        view?.openMenu()
    }
    
    func setupNavigationTitle(){
        view?.renderNavigationTitle(with: "雲端硬碟")
    }
}
