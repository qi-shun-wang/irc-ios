//
//  DeviceDiscoveryInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/30.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import AVFoundation
class DeviceDiscoveryInteractor {
    var soundEffect: AVAudioPlayer?
    // MARK: Properties
    weak var output: DeviceDiscoveryInteractorOutput?
    fileprivate var foundDevices:[Device] = []
    fileprivate var isStop:Bool = false
    fileprivate var manager:DiscoveryServiceManagerProtocol
    
    init(manager:DiscoveryServiceManagerProtocol) {
        self.manager = manager
        self.manager.setDelegate(as: self)
    }
    
}

extension DeviceDiscoveryInteractor: DiscoveryServiceManagerDelegate {
    func failureConnection() {
        output?.failureConnection()
    }
    
    func didDisconnectedDevice() {
        output?.didDisconnected()
    }
    
    func didSelectedDevice(_ device: Device) {
        output?.didConnected(device: device)
        manager.clearDeviceCaches()
    }
    
    func deviceNotFound(){
        if isStop {output?.deviceNotFound()}
    }
    
    func didFound(devices: [Device]) {
        foundDevices = devices
        output?.didFetched(devices: devices)
    }
    
}

extension DeviceDiscoveryInteractor: DeviceDiscoveryUseCase {
    
    // TODO: Implement use case methods
    func stopSearch() {
        isStop = true
        manager.stopDiscovering()
    }
    
    func getDevices() {
        manager.fetchingDevices()
    }
    
    func startSearch() {
        isStop = false
        foundDevices = []
        manager.clearDeviceCaches()
        manager.startDiscovering()
    }
    func hasFound() {
        output?.didFoundDevice()
    }
    func select(device: Device) {
        manager.connect(device: device)
    }
    func clearCached() {
        foundDevices = []
        manager.clearDeviceCaches()
    }
    func playSoundEffect() {
        let path = Bundle.main.path(forResource: "search_success", ofType:"wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }
    
    func playSuccessSoundEffect() {
        let path = Bundle.main.path(forResource: "success", ofType:"mp3")!
        let url = URL(fileURLWithPath: path)
        
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }
}
