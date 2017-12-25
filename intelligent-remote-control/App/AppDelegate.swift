//
//  AppDelegate.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appState:AppState?
    lazy var path = Bundle.main.path(forResource: "AppState", ofType: "plist")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let root = RootRouter()
        root.presentRootScreen(in: window!)
        appState = AppState.shared
        appState?.load(filePath: path)

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        appState?.update(filePath: path)
    }
    
    
}
extension AppDelegate :ObserveStateAbility {
    func didChanged(_ state: State) {
        
    }
    func willChanged(_ state: State) {
        
    }
}

/*
 extend AppDelegate to check for VCs that conform to Rotatable. If they do allow device rotation.
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
