//
//  RootRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit
import SlideMenuControllerSwift



protocol RootRouterDelegate:class {
    func changeMain()
}
class RootRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule() -> RootViewController {

        
        let presenter = RootPresenter()
        let router = RootRouter()
        let interactor = RootInteractor()
//        let dlnaManager = DLNAMediaManager()
//        dlnaManager.startServer()
//        let baseTabBar = MediaShareRouter.setupModule(dlnaManager: dlnaManager)
//        let baseTabBar = EditFolderRouter.setupModule()
        let baseTabBar = BaseTabBarRouter.setupModule()
//        let baseTabBar = MediaSharePhotosRouter.setupModule()
//        let baseTabBar = IntroductionRouter.setupModule(delegate: router)
        let menu = MenuRouter.setupModule()
        let root = RootViewController(mainViewController: baseTabBar, leftMenuViewController: menu)
        
        root.presenter =  presenter
        
        presenter.view = root
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = root
        
        interactor.output = presenter
        
        return root
    }
}

extension RootRouter: IntroductionRouterDelegate {
    func changeMain() {
        let baseTabBar = BaseTabBarRouter.setupModule()
        (view as? RootViewController)?.changeMainViewController(baseTabBar, close: true)
    }
}

extension RootRouter: RootWireframe {
    // TODO: Implement wireframe methods
    
    func presentRootScreen(in window: UIWindow) {
        window.makeKeyAndVisible()
        window.rootViewController = RootRouter.setupModule()
    }
}
