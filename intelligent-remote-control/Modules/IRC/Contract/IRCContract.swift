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
    func performAction(state:PerformState, with sendCode:SendCode)
    func performLongAction(with sendCode:SendCode)
    func performInput(text:String)
    func performMotion(with dx:Float,_ dy:Float)
    func performMotionTap()
    func performGameAction(with sendCode:SendCode)
    func performGameDPad(state:PerformState, with code:SendCode)
    func presentDeviceDiscovery()
    func updateConnectionStatus()
    func performGameAxis(with angle: Double, displacement: Double)
    func performGameAxis(with code:SendCode.game_axis, shift: Float)
    func performModeChanged()
    
}

protocol IRCUseCase: class {
    // TODO: Declare use case methods
    func perform(keyevent code:KeyCode)
    func perform(state:PerformState, sendevent code:SendCode)
    func performLong(sendevent code:SendCode)
    func perform(motion serialNum:String)
    func performMotionTap()
    func perform(input text:String)
    func fetchGameNumber()
    func performGameDPad(code:SendCode)
    func performGame(code:SendCode)
    func performGameAxis(code:SendCode.game_axis, value:String)
    func getCurrentConnectedDevice()
    func startWiFiMonitor()
    
}

protocol IRCInteractorOutput: class {
    // TODO: Declare interactor output methods
    func successConnected(device:Device)
    func failureConnected()
    func didNotConnectedWiFi()
    func didConnectedWiFi()
}

protocol IRCWireframe: class {
    // TODO: Declare wireframe methods
    func presentDeviceDiscovery()
}
