//
//  BaseTabBarController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let irc = IRCRouter.setupModule()
        let karaoke = KaraokeRouter.setupModule()
        let web = WebBrowserRouter.setupModule()
        let more = MoreRouter.setupModule()
        
        irc.tabBarItem = UITabBarItem(title: "遙控器", image: UIImage(named:"tab_remote_icon"), selectedImage: nil)
        karaoke.tabBarItem = UITabBarItem(title: "K歌點唱", image: UIImage(named:"tab_mic_icon"), selectedImage: nil)
        web.tabBarItem = UITabBarItem(title: "網頁導覽", image: UIImage(named:"tab_web_icon"), selectedImage: nil)
        more.tabBarItem = UITabBarItem(title: "更多", image: UIImage(named:"tab_more_icon"), selectedImage: nil)
        
        viewControllers = [irc,karaoke,web,more]
    }
}
