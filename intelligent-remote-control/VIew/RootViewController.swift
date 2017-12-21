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
    
    var viewModel: RootViewModel?
    
    
    override func awakeFromNib() {
        
        viewModel = RootViewModel(view: self)
        viewModel?.setupMainViewController(within: Storyboard.base)
        viewModel?.setupLeftViewController(within: Storyboard.menu)
        
        
        
        super.awakeFromNib()
        
        
    }
    
}

extension RootViewController:RootViewControllerProtocol {
    
    func setupRootGesture(isEnable: Bool) {
        //avoid shrink Main view controller's view content
        SlideMenuOptions.contentViewScale = 1
        SlideMenuOptions.panGesturesEnabled = isEnable
        SlideMenuOptions.contentViewOpacity = 0
//        SlideMenuOptions.hideStatusBar = false
    }
    
    func setupLeftViewController(within storyboard: Storyboard){
        let storyboard = UIStoryboard(name: storyboard.name, bundle:  nil)
        let leftVC = storyboard.instantiateInitialViewController()
        
        leftViewController = leftVC
        
    }
    
    func setupMainViewController(within storyboard: Storyboard) {
        
        let storyboard = UIStoryboard(name: storyboard.name, bundle:  nil)
        let nc = storyboard.instantiateInitialViewController()
        mainViewController = nc
        
    }
    
}

