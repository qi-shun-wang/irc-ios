//
//  IRCServiceContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/29.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol CodeSender {
    func dispatch(code:SendCode)
    func dispatch(code:KeyCode)
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
