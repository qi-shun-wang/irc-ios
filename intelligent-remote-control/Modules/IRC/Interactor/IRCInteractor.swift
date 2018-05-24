//
//  IRCInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class IRCInteractor {

    // MARK: Properties
    weak var manager:DiscoveryServiceManagerProtocol?
    weak var output: IRCInteractorOutput?
    var isFirstResponse:Bool = true
    
    @objc func networkStatusChanged(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        print(userInfo as Any)
        checkNetworkStatus()
    }
    
    private func checkNetworkStatus() {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline ,.online(.wwan):
            output?.didNotConnectedWiFi()
        case .online(.wiFi):
            if isFirstResponse {
                isFirstResponse = false
            }
            output?.didConnectedWiFi()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension IRCInteractor: IRCUseCase {
   
    func perform(state: PerformState, sendevent code: SendCode) {
        switch state {
        case .normal: manager?.service.send(code: code)
        case .began: manager?.service.sendBegan(code: code)
        case .end: manager?.service.sendEnd(code: code)
        }
    }

    func performLong(sendevent code: SendCode) {
        manager?.service.sendL(code: code)
    }
    
    func perform(keyevent code: KeyCode) {
        manager?.service.key(code: code)
    }
   
    func perform(motion serialNum: String) {
        manager?.service.motion(serialNum)
    }
    
    func perform(input text:String){
        manager?.service.input(text: text)
    }
    
    func getCurrentConnectedDevice() {
        guard let device = manager?.getCurrentConnectedDevice() else {
            output?.failureConnected()
            return
        }
        output?.successConnected(device: device)
    }
    
    func startWiFiMonitor() {
        NotificationCenter.default.addObserver(self, selector: #selector(MediaShareInteractor.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
    }
}
