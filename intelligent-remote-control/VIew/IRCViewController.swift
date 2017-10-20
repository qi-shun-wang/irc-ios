//
//  IRCViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit


class IRCViewController: UIViewController {

    weak var viewModel:IRCViewModel?
    override func awakeFromNib() {
        viewModel = IRCViewModel(view: self)
        super.awakeFromNib()
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
       
    }

    @IBAction func toggleMenu(_ sender: UIButton) {
        
        viewModel?.openMenu()
    }
    
}
extension IRCViewController:IRCViewControllerProtocol{
    func openMenu() {
        
        
        slideMenuController()?.openLeft()
    }
}

