//
//  CloudDriveViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class CloudDriveViewModel: BaseViewModel {
    
    init(view: CloudDriveViewControllerProtocol) {
        super.init(view: view)
        self.view = view
        self.title = "雲端硬碟"
    }
    
}
