//
//  IRCViewModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class IRCViewModel: NSObject {
    
   weak var view:IRCViewControllerProtocol?
    
    init(view:IRCViewControllerProtocol) {
        self.view = view
        
    }
    
    func openMenu() {
        view?.openMenu()
    }
}
