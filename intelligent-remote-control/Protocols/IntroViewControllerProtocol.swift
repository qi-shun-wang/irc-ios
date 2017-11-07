//
//  IntroViewControllerProtocol.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/5.
//  Copyright © 2017年 ising99. All rights reserved.
//

protocol IntroViewControllerProtocol: class {

    func swipeLeft()
    func swipeRight()
    func showExitButton()
    func hideExitButton()
    func exit(to storyboard: Storyboard)
    func render(with description: String,_ imageName: String)
    
}

