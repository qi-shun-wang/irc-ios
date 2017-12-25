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
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = true
    }
  
    func realNavigationBarFrame()->CGRect {
        let realWidth = frame.width
        let realHeight = frame.height + statusBarHeight()
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

 