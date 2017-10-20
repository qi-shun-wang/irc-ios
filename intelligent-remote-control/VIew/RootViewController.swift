//
//  RootViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class RootViewController: SlideMenuController {
    
    var viewModel:RootViewModel?
    
    
    override func awakeFromNib() {
        
        viewModel = RootViewModel(view: self)
        viewModel?.setupMainViewController(with:Storyboard.main.string)
        viewModel?.setupLeftViewController(with: Storyboard.menu.string)
        //        viewModel?.setupRightViewController(with: "")
        super.awakeFromNib()
        
        
    }
    
}

extension RootViewController:RootViewControllerProtocol {
    func setupLeftViewController(with identifier:String) {
        let storyboard = UIStoryboard(name: identifier ,bundle:  nil)
        let leftVC = storyboard.instantiateInitialViewController()
        
        leftViewController = leftVC
        
    }
    
    //    func setupRightViewController(with identifier:String) {
    //
    //        if let rightVC = self.storyboard?.instantiateViewController(withIdentifier:identifier) {
    //            rightViewController = rightVC
    //        }
    //
    //    }
    
    func setupMainViewController(with identifier:String) {
        
        let storyboard = UIStoryboard(name: identifier ,bundle:  nil)
        let nc = storyboard.instantiateInitialViewController()
        mainViewController = nc
        
    }
}
