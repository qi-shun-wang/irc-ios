//
//  TipsViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class TipsViewModel: BaseViewModel {
    
    init(view: TipsViewControllerProtocol) {
        super.init(view: view)
        self.view = view
        self.title = "操作使用提示"
    }
   
}
