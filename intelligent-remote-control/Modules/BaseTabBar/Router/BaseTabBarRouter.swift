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
        let karaoke = KaraokeRouter.setupModule()
        let web = WebBrowserRouter.setupModule()
        let movie = MovieRouter.setupModule()
        let more = MoreRouter.setupModule()
        
        irc.tabBarItem = UITabBarItem(title: "遙控器", image: UIImage(named:"tab_remote_icon"), selectedImage: nil)
        karaoke.tabBarItem = UITabBarItem(title: "K歌點唱", image: UIImage(named:"tab_mic_icon"), selectedImage: nil)
        web.tabBarItem = UITabBarItem(title: "網頁導覽", image: UIImage(named:"tab_web_icon"), selectedImage: nil)
        movie.tabBarItem = UITabBarItem(title: "中華影視", image: UIImage(named:"tab_tv_icon"), selectedImage: nil)
        more.tabBarItem = UITabBarItem(title: "更多", image: UIImage(named:"tab_more_icon"), selectedImage: nil)
        
        (view as? UITabBarController)?.viewControllers = [irc,karaoke,web,movie,more]
    }
}
