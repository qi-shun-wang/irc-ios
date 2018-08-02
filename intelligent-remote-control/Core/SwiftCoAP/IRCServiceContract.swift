//
//  IRCServiceContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/29.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

enum PerformState {
    case normal
    case began
    case end
}

protocol CodeSender {
    func dispatch(state:PerformState, code:SendCode)
    func dispatch(code:SendCode.game_axis,value:Float)
}

protocol DiscoveryServiceManagerProtocol:class {
    var service:RemoteControlCoAPService {get}
    func setDelegate(as receiver:DiscoveryServiceManagerDelegate)
    func getDelegate() -> DiscoveryServiceManagerDelegate?
    
    func startDiscovering()
    func stopDiscovering()
    func fetchingDevices()
    func clearDeviceCaches()
    func connect(device:Device)
    func disconnect()
    func getCurrentConnectedDevice()->Device?
}

protocol Device {
    var name:String {get set}
    var address:String {get set}
    var backupAddress:String {get set}
}

protocol DiscoveryServiceManagerDelegate {
    func deviceNotFound()
    func failureConnection()
    func didDisconnectedDevice()
    func didSelectedDevice(_ device:Device)
    func didFound(devices:[Device])
    func hasFound()
}
