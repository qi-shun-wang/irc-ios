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

    // TODO: Implement use case methods
    func perform(_ type: KeyCode) {
        manager?.service.key(code: type)
    }
    
    func perform(motion serialNum: String) {
        manager?.service.motion(serialNum)
    }
    
    func getCurrentConnectedDevice() {
        guard let device = manager?.getCurrentConnectedDevice() else {
            output?.failureConnected()
            return
        }
        output?.successConnected(device: device)
    }
}
