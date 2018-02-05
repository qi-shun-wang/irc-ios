//
//  IRCServiceContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/29.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
protocol DiscoveryServiceManagerProtocol:class {
    var service:RemoteControlCoAPService {get}
    func setDelegate(as receiver:DiscoveryServiceManagerDelegate)
    func getDelegate() -> DiscoveryServiceManagerDelegate?
    
    func startDiscovering()
    func stopDiscovering()
    func fetchingDevices()
    func clearDeviceCaches()
    func connect(device:Device)
    func getCurrentConnectedDevice()->Device?
}

protocol Device {
    var name:String {get set}
    var address:String {get set}
}

protocol DiscoveryServiceManagerDelegate {
    func deviceNotFound()
    func didSelectedDevice(_ device:Device)
    func didFound(devices:[Device])
    func hasFound()
}
