//
//  IRCViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit


class IRCViewController: UIViewController {
    
    var viewModel:IRCViewModel?
    
    @IBAction func toggleMenu(_ sender: UIButton) {
        
        if viewModel == nil {
            viewModel = IRCViewModel(view: self)
        }
        viewModel?.openMenu()
    }
    
}


extension IRCViewController:IRCViewControllerProtocol{
    func openMenu() {
        
        slideMenuController()?.openLeft()
    }
}

