//
//  File.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/18.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class WebBookmarksRouting:WebBookmarksRoutingProtocol {
    static func createWebBookmarksModule() -> UIViewController {
        let story = UIStoryboard(name: "WebBookmarks", bundle: Bundle.main)
        let navigationController = story.instantiateViewController(withIdentifier: "WebBookmarksNavigationController")
        guard let view = navigationController.childViewControllers.first as? WebBookmarksViewController else {
            print("WebBookmarksRouting Eror:RootViewController of NavigationController doesn't setup")
            return UIViewController()
        }
        //view.setup vipr here....
        
        return navigationController
    }
}
