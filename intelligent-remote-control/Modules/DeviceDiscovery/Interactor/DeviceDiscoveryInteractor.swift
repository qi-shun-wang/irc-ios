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
    var bombSoundEffect: AVAudioPlayer?
    // MARK: Properties
    weak var output: DeviceDiscoveryInteractorOutput?
    fileprivate var foundDevices:[Device] = []
    fileprivate var manager:DiscoveryServiceManagerProtocol
    
    init(manager:DiscoveryServiceManagerProtocol) {
        self.manager = manager
        self.manager.setDelegate(as: self)
    }
    
}

extension DeviceDiscoveryInteractor: DiscoveryServiceManagerDelegate {
    
    func didSelectedDevice(_ device: Device) {
        output?.didConnected(device: device)
    }
    
    func didFound(devices: [Device]) {
        foundDevices = devices
        output?.didFetched(devices: devices)
    }
    
}

extension DeviceDiscoveryInteractor: DeviceDiscoveryUseCase {
    
    // TODO: Implement use case methods
    func stopSearch() {
        manager.stopDiscovering()
    }
    
    func getDevices() {
        manager.fetchingDevices()
    }
    
    func startSearch() {
        manager.startDiscovering()
    }
    func hasFound() {
        output?.hasFound()
    }
    func select(device: Device) {
        manager.connect(device: device)
    }
    
    func playSoundEffect() {
        let path = Bundle.main.path(forResource: "search_success", ofType:"wav")!
        let url = URL(fileURLWithPath: path)
        
        do {
            bombSoundEffect = try AVAudioPlayer(contentsOf: url)
            bombSoundEffect?.play()
        } catch {
            // couldn't load file :(
        }
    }
}
