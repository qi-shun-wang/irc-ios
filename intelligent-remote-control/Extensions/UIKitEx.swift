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



protocol Rotatable: AnyObject {
    func resetToPortrait()
}

extension Rotatable where Self: UIViewController {
    func resetToPortrait() {
        UIDevice.current.setValue(Int(UIInterfaceOrientation.portrait.rawValue), forKey: "orientation")
    }
}

/*
 Next, extend AppDelegate to check for VCs that conform to Rotatable. If they do allow device rotation.
 Remember, it's up to the conforming VC to reset the device rotation back to portrait.
 */

// MARK: - Device rotation support

extension AppDelegate {
    // The app disables rotation for all view controllers except for a few that opt-in by conforming to the Rotatable protocol
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        guard
            let _ = topViewController(for: window?.rootViewController) as? Rotatable
            else { return .portrait }
        
        return .landscape
    }
    
    private func topViewController(for rootViewController: UIViewController!) -> UIViewController? {
        guard let rootVC = rootViewController else { return nil }
        
        if rootVC is UITabBarController {
            let rootTabBarVC = rootVC as! UITabBarController
            
            return topViewController(for: rootTabBarVC.selectedViewController)
        } else if rootVC is UINavigationController {
            let rootNavVC = rootVC as! UINavigationController
            
            return topViewController(for: rootNavVC.visibleViewController)
        } else if let rootPresentedVC = rootVC.presentedViewController {
            return topViewController(for: rootPresentedVC)
        }
        
        return rootViewController
    }
}


