//
//  IRCViewControllerProtocol.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

protocol IRCViewControllerProtocol: BaseViewControllerProtocol {
    func setupContainer()
    
    func setupPowerContainer()
    func setupModeContainer()
    func setupOperationContainer()
}