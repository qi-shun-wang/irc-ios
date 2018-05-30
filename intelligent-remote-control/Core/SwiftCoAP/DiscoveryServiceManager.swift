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
    fileprivate var isWiFiOpened:Bool = false
    let service:RemoteControlCoAPService
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    init(_ service:RemoteControlCoAPService) {
        self.service = service
        super.init()
        socket = GCDAsyncUdpSocket(delegate: self, delegateQueue: DispatchQueue.main)
        
        NotificationCenter.default.addObserver(self, selector: #selector(DiscoveryServiceManager.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
    }
    
    func checkNetworkStatus() throws {
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline ,.online(.wwan):
            throw WifiConnectedError.notConnectedToWifi
        case .online(.wiFi):
            print("Connected via WiFi")
        }
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        print(userInfo as Any)
        
        let status = Reach().connectionStatus()
        switch status {
        case .online(.wiFi):
            isWiFiOpened = true
        default:
            isWiFiOpened = false
        }
    }
    
    fileprivate var currentFoundDevices:Set<KODConnection> = [] {
        didSet{
            if currentFoundDevices.count > 0 {
                delegate?.hasFound()
            }
            
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
        service.wireCheck(callback: self)
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
        guard isWiFiOpened else {delegate?.failureConnection();return}
        
        guard currentFoundDevices.count == 0 else {return}
        delegate?.deviceNotFound()
        guard currentConnectedDevice == nil else {return}
        
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
        service.setup(address: device.backupAddress)
    }
    
    func disconnect() {
        currentConnectedDevice = nil
        delegate?.didDisconnectedDevice()
    }
}

extension DiscoveryServiceManager : GCDAsyncUdpSocketDelegate{
    
    func udpSocket(_ sock: GCDAsyncUdpSocket, didReceive data: Data, fromAddress address: Data, withFilterContext filterContext: Any?) {
        
        print("didReceiveData")
        guard let backupAddress = JSON(data)["BackupAddress"].string, let address = JSON(data)["Address"].string, let name = JSON(data)["Name"].string else {return}
        guard backupAddress.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "" else {return}
        guard !currentFoundDevices.contains(KODConnection(backupAddress: backupAddress, address: address, name: name)) else {return}
        currentFoundDevices.insert(KODConnection(backupAddress: backupAddress, address: address, name: name))
        
        print(JSON(data))
        
    }
}


extension DiscoveryServiceManager : SCClientDelegate {
    
    func swiftCoapClient(_ client: SCClient, didReceiveMessage message: SCMessage) {
        print("---didReceiveMessage->:",message.payloadRepresentationString())
        let json = JSON.init(parseJSON: message.payloadRepresentationString())
        guard let backupAddress = json["BackupAddress"].string, let address = json["Address"].string, let name = json["Name"].string else {return}
        guard backupAddress.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "" else {return}
        guard !currentFoundDevices.contains(KODConnection(backupAddress: backupAddress, address: address, name: name)) else {return}
        currentFoundDevices.insert(KODConnection(backupAddress: backupAddress, address: address, name: name))
    }
    
    func swiftCoapClient(_ client: SCClient, didSendMessage message: SCMessage, number: Int) {
        print("---didSendMessage->:",message.payloadRepresentationString())
    }
    
    func swiftCoapClient(_ client: SCClient, didFailWithError error: Error) {
        print("---didFailWithError->:",error)
    }
}

