//
//  BaseViewControllerProtocol.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

protocol BaseViewControllerProtocol: class, MenuOpenable, NavigateAbility {
    
    func setupViewBackgroundColor(named:String)
}
