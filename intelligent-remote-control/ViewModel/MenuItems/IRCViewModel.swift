//
//  IRCViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class IRCViewModel: BaseViewModel {
    
    init(view: IRCViewControllerProtocol) {
        super.init(view: view)
        self.view = view
        self.title = "遙控器"
    }
    
}
