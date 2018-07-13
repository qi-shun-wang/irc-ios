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
    var gameNumber:Int = 2
    
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
    
    func fetchGameNumber() {
        manager?.service.detectGameEventNumber(callback: self)
    }
    
    func performGameAxis(code:SendCode.game_axis,value:String){
        manager?.service.gameAxisEvent(eventNumber: gameNumber, code: code, value: value)
    }
    
    func performGameDPad(code: SendCode) {
        manager?.service.gameDPadEvent(eventNumber: gameNumber, code: code)
    }
    
    func performGame(code: SendCode) {
        manager?.service.gameEvent(eventNumber: gameNumber, code: code)
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

extension IRCInteractor:SCClientDelegate {
    
    func swiftCoapClient(_ client: SCClient, didReceiveMessage message: SCMessage) {
        gameNumber = Int(message.payloadRepresentationString()) ?? 2
    }
}
