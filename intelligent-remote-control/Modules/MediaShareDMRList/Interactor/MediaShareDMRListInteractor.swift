//
//  MediaShareDMRListInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareDMRListInteractor {
    
    // MARK: Properties
    
    weak var output: MediaShareDMRListInteractorOutput?
    weak var dlnaManger:DLNAMediaManager! {
        didSet{
            dlnaManger.delegate = self
        }
    }
    
    fileprivate var searchTimer:Timer?
 
    var devices:[DMR] = [] {
        didSet {
            output?.fetched(devices)
        }
    }
}

extension MediaShareDMRListInteractor: MediaShareDMRListUseCase {
    
    // TODO: Implement use case methods
    func startDiscoveringDMR() {
        devices = [LocalDevice(name: "iPhone")]
        dlnaManger.startDiscover()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.stopDiscoveringDMR()
        }
    }
    
    func stopDiscoveringDMR() {
        dlnaManger.stopDiscover()
        output?.stopDiscoveringDMR()
    }
    
    func chooseDevice(at index: Int) {
        guard index != 0 else {
            //ignore local device selected
            dlnaManger.removeCurrentDevice()
            output?.didChoosedLocalDevice()
           return
        }
        dlnaManger.setupCurrent(device: devices[index])
        output?.didChoosedDevice(devices[index])
    }
}

extension MediaShareDMRListInteractor:DLNAMediaManagerDelegate {
    func didEventRecieved(_ event: Dictionary<AnyHashable, Any>) {
        
    }
    
    func didFailureChangeVolume() {
        
    }
    
    func didFailureChangeMute() {
        
    }
    
    func didFind(device: DMR) {
        devices.append(device)
        print(device)
    }
    
    func didRemove(at index: Int) {
        devices.remove(at: index)
    }
    
    func didChangeMute() {
        
    }
    
    func didChangeVolume() {
        
    }
    
    func didSetupTransportService() {
        
    }
    
    func didSetupRenderService() {
        
    }
    
    
} 

struct LocalDevice:DMR {
    var name: String
    var ip:String
    var isConnected: Bool
    init(name:String,isConnected:Bool = false) {
        ip = ""
        self.name = name
        self.isConnected = isConnected
    }
}
