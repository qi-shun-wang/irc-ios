//
//  NavigateAbility.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

protocol NavigateAbility {
    
    func renderNavigationTitle(with text: String)
    func renderNavigationBarBackgroundImage(named filename: String)
    func renderNavigationItemIcon(named filename: String)
    
}
