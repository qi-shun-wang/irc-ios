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
}

extension IRCInteractor: IRCUseCase {

    func perform(sendevent code: SendCode) {
        manager?.service.send(code: code)
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
}
