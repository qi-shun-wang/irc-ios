//
//  RootViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import SlideMenuControllerSwift
import UIKit

class RootViewController: SlideMenuController, StoryboardLoadable {
    
    // MARK: Properties
    
    var presenter: RootPresentation?
    
    // MARK: Lifecycle
    override func awakeFromNib() {
        presenter?.awakeFromNib()
        super.awakeFromNib()
    }
}

extension RootViewController: RootView {
    // TODO: implement view output methods
    
    func setupRootStyle() {
        //avoid shrink Main view controller's view content
        SlideMenuOptions.contentViewScale = 1
        SlideMenuOptions.panGesturesEnabled = true
        SlideMenuOptions.contentViewOpacity = 0
        //        SlideMenuOptions.hideStatusBar = false
    }
    
}
