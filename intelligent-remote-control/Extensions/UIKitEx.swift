//
//  UIKitEx.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/15.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit
extension UINavigationBar {
    
    func transparentNavigationBar() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
  
    func realNavigationBarFrame()->CGRect {
        let realWidth = self.frame.width
        let realHeight = self.frame.height + statusBarHeight()
        return CGRect(x: 0, y: 0, width: realWidth, height: realHeight)
    }
    
}
extension UIView {
    
    func statusBarHeight() -> CGFloat {
        return UIApplication.shared.statusBarFrame.height
    }
    
    func statusBarWidth() -> CGFloat {
        return UIApplication.shared.statusBarFrame.width
    }
}
extension UITabBar {
//    override open func sizeThatFits(_ size: CGSize) -> CGSize {
//
////        return CGSize(width: UIScreen.main.bounds.width, height: 55)
//
////        (768.0, 49.0)
////            - width : 768.0
////        - height : 49.0
////        320.0
//        return CGSize(width: UIScreen.main.bounds.width, height: 95)
//    }
}

extension UIViewController {
    func changeTabBarItemTitlePosition(horizontal: CGFloat = 0, vertical: CGFloat = 0) {
         UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: horizontal, vertical: vertical)
    }
}

