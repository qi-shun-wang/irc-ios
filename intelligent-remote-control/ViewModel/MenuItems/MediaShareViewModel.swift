//
//  MediaShareViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MediaShareViewModel: BaseViewModel {
    
    init(view: MediaShareViewControllerProtocol) {
        super.init(view: view)
        self.view = view
        self.title = "媒體分享"
    }

}
