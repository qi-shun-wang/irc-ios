//
//  BaseNavigatedViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/17.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class BaseNavigatedViewController: UIViewController {
 
}
extension BaseNavigatedViewController: NavigateAbility {
    func renderNavigationBarBackground() {
        let bar = self.navigationController?.navigationBar
        if let backgroundFrame = bar?.realNavigationBarFrame() {
            let navigationBarBackground = UIImageView(frame: backgroundFrame)
            navigationBarBackground.image = UIImage(named: "navi_bg")
            self.view.addSubview(navigationBarBackground)
        }
        bar?.transparentNavigationBar()
    }
    func renderNavigationTitle(with text: String) {
        
    }
}
