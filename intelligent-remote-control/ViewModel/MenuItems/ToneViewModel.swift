//
//  ToneViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class ToneViewModel: BaseViewModel {
    
    init(view: ToneViewControllerProtocol) {
        super.init(view: view)
        self.view = view
        self.title = "定調助手"
    }
    
}
