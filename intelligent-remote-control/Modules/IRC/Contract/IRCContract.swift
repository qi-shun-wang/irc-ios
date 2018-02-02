//
//  IRCContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol IRCView: BaseView {
    // TODO: Declare view methods
    
}

protocol IRCPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func performAction(with keyCode:KeyCode)
    func performMotion(with dx:Float,_ dy:Float)
    func presentDeviceDiscovery()
    func updateConnectionStatus()
}

protocol IRCUseCase: class {
    // TODO: Declare use case methods
    func perform(_ type:KeyCode)
    func perform(motion serialNum:String)
    func getCurrentConnectedDevice()
    
}

protocol IRCInteractorOutput: class {
    // TODO: Declare interactor output methods
    func successConnected(device:Device)
    func failureConnected()
}

protocol IRCWireframe: class {
    // TODO: Declare wireframe methods
    func presentDeviceDiscovery()
}
