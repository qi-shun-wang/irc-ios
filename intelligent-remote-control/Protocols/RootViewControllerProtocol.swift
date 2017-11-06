//
//  RootViewControllerProtocol.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

protocol RootViewControllerProtocol: class {
   
    func setupMainViewController(within storyboard:Storyboard)
    func setupLeftViewController(within storyboard:Storyboard)
    func setupRootGesture(isEnable:Bool)

}

