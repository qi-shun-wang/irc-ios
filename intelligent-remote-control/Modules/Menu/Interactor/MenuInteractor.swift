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

    weak var output: MenuInteractorOutput?
}

extension MenuInteractor: MenuUseCase {
    
    // TODO: Implement use case methods
    
    func searchConnections() {
        let fake = [
            KODConnection(id: "1", ip: "192.168.1.1", name: "KOD iSing99-01"),
            KODConnection(id: "2", ip: "192.168.1.11", name: "KOD iSing99-02"),
        ]
        output?.didFetchConnections(fake)
    }
    
    func updateConnections() {
        let fake = [
            KODConnection(id: "3", ip: "192.168.1.2", name: "KOD iSing99-03"),
            KODConnection(id: "4", ip: "192.168.1.12", name: "KOD iSing99-04"),
            ]
        output?.didFetchConnections(fake)
    }
}
