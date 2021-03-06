//
//  BaseTabBarRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class BaseTabBarRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    weak var manager:DiscoveryServiceManagerProtocol?
    // MARK: Static methods
    
    static func setupModule(with manager:DiscoveryServiceManagerProtocol) -> BaseTabBarViewController {
        let viewController = UIStoryboard.loadViewController() as BaseTabBarViewController
        let presenter = BaseTabBarPresenter()
        let router = BaseTabBarRouter()
        let interactor = BaseTabBarInteractor()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        router.manager = manager
        
        interactor.output = presenter
        
        return viewController
    }
    
}

extension BaseTabBarRouter: BaseTabBarWireframe {
    // TODO: Implement wireframe methods
    func presentTabs() {
        let irc = IRCRouter.setupModule(with: manager!)
//        let api = Endpoint(host: "sim.ising99.com", port: 8072,api_path: "api/v1/")
//        let handler = HTTPHandler.Use
//        let karaokeService = KaraokeService(endPoint: api, handler: handler)
//        let karaoke = KaraokeRouter.setupModule(with: karaokeService)
//        let web = WebBrowserRouter.setupModule()
        //        let movie = MovieRouter.setupModule()
//        let more = MoreRouter.setupModule()
        let dlnaManager = DLNAMediaManager()
        let mediaShare = MediaShareRouter.setupModule(dlnaManager: dlnaManager)
        
        irc.tabBarItem = UITabBarItem(title: "遙控器", image: UIImage(named:"tab_remote_icon"), selectedImage: nil)
//        karaoke.tabBarItem = UITabBarItem(title: "愛唱點歌", image: UIImage(named:"tab_mic_icon"), selectedImage: nil)
//        web.tabBarItem = UITabBarItem(title: "網址導航", image: UIImage(named:"tab_web_icon"), selectedImage: nil)
        //        movie.tabBarItem = UITabBarItem(title: "Hami影視", image: UIImage(named:"tab_tv_icon"), selectedImage: nil)
//        more.tabBarItem = UITabBarItem(title: "更多", image: UIImage(named:"tab_more_icon"), selectedImage: nil)
        mediaShare.tabBarItem = UITabBarItem(title: "媒體分享", image: UIImage(named:"tab_cast_icon"), selectedImage: nil)
        
        (view as? UITabBarController)?.viewControllers = [
            irc,
//            karaoke,
//            movie,
//            web,
//            more,
            mediaShare
        ]
    }
}
