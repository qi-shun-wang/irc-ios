//
//  MenuInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuInteractor {
    
    // MARK: Properties
    fileprivate var serviceMananger:DiscoveryServiceManagerProtocol
    
    init(serviceMananger:DiscoveryServiceManagerProtocol) {
        self.serviceMananger = serviceMananger
        self.serviceMananger.setDelegate(as: self)
    }
    
    weak var output: MenuInteractorOutput?
    fileprivate var foundDevices:[Device] = []
}

extension MenuInteractor: DiscoveryServiceManagerDelegate {
    func deviceNotFound() {
        
    }
    
    func hasFound() {
        
    }
    
    func didSelectedDevice(_ device: Device) {
        output?.didConnected(device: device)
        serviceMananger.stopDiscovering()
    }
    
    
    func didFound(devices: [Device]) {
        foundDevices = devices
        output?.didFetched(devices: devices)
    }
    
}
extension MenuInteractor: MenuUseCase {
    
    // TODO: Implement use case methods
    func connectDevice(at indexPath: IndexPath) {
        guard indexPath.row < foundDevices.count else{return}
        serviceMananger.connect(device:  foundDevices[indexPath.row])
    }
    
    func searchDevices() {
        serviceMananger.startDiscovering()
    }
    
    func getDevices() {
        serviceMananger.fetchingDevices()
    }
}
