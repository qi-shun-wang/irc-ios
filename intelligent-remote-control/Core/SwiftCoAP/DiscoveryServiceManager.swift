//
//  DiscoveryServiceManager.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/29.
//  Copyright © 2018年 ising99. All rights reserved.
//

import CocoaAsyncSocket
import SwiftyJSON

class DiscoveryServiceManager : NSObject {
    var delegate: DiscoveryServiceManagerDelegate?
    var socket:GCDAsyncUdpSocket!
    private let multicastPort: UInt16 = 9999
    private let multicastAddress: String = "239.0.0.0"
    
    let service:RemoteControlCoAPService
    init(_ service:RemoteControlCoAPService) {
        self.service = service
        super.init()
        socket = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
    }
    
    fileprivate var currentFoundDevices:Set<KODConnection> = [] {
        didSet{
            delegate?.hasFound()
        }
    }
    fileprivate var currentConnectedDevice:Device? {
        didSet{
            guard let device = currentConnectedDevice else {return}
            delegate?.didSelectedDevice(device)
        }
    }
}

extension DiscoveryServiceManager : DiscoveryServiceManagerProtocol {
    
    func getCurrentConnectedDevice() -> Device? {
        return currentConnectedDevice
    }
    
    func setDelegate(as receiver: DiscoveryServiceManagerDelegate) {
        self.delegate = receiver
    }
    
    func getDelegate() -> DiscoveryServiceManagerDelegate? {
        return delegate
    }
    
    func startDiscovering() {
        if !socket.isClosed() {
            socket.close()
        }
        do {
            try socket.bind(toPort: multicastPort)
            socket.setIPv4Enabled(true)
            socket.setIPv6Enabled(false)
            try socket.enableBroadcast(true)
            try socket.joinMulticastGroup(multicastAddress)
            try socket.beginReceiving()
            let when = DispatchTime.now() + 8
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.check()
            }
        } catch {
            print(error)
        }
    }
    
    private func check(){
        if currentFoundDevices.count == 0 {
            delegate?.deviceNotFound()
        }
    }
    
    func stopDiscovering() {
        socket.close()
    }
    
    func fetchingDevices() {
        delegate?.didFound(devices: Array(currentFoundDevices))
    }
    
    func clearDeviceCaches() {
        currentFoundDevices = []
    }
    
    func connect(device: Device) {
        currentConnectedDevice = device
        service.setup(address: device.address)
    }
    
    
}

extension DiscoveryServiceManager : GCDAsyncUdpSocketDelegate{
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        
        print("didReceiveData")
        guard let address = JSON(data)["Address"].string, let name = JSON(data)["Name"].string else {return}
        guard !currentFoundDevices.contains(KODConnection(address: address, name: name)) else {return}
        currentFoundDevices.insert(KODConnection(address: address, name: name))
        
        print(JSON(data))
        
    }
}
