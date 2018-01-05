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
    fileprivate var dlnaManger:DLNAMediaManager
     fileprivate var searchTimer:Timer?
    init(dlnaManager:DLNAMediaManagerProtocol) {
        self.dlnaManger = dlnaManager as! DLNAMediaManager
        self.dlnaManger.delegate = self
    }
    
    var devices:[DMR] = [] {
        didSet {
            output?.fetched(devices)
        }
    }
}

extension MediaShareDMRListInteractor: MediaShareDMRListUseCase {
    
    // TODO: Implement use case methods
    func startDiscoveringDMR() {
        devices = []
        dlnaManger.startDiscover()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            self.stopDiscoveringDMR()
        }
    }
    
    func stopDiscoveringDMR() {
        dlnaManger.stopDiscover()
        output?.stopDiscoveringDMR()
        
    }
  
    func didChoosedDevice(at index: Int) {
        dlnaManger.setupCurrent(device: devices[index])
    }
}

extension MediaShareDMRListInteractor:DLNAMediaManagerDelegate {
    
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
