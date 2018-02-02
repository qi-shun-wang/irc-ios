//
//  MenuContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol MenuView: BaseView {
    // TODO: Declare view methods
    func updateMenuTable()
}

protocol MenuPresentation: class {
    // TODO: Declare presentation methods
    func numberOfRowsInSection(_ section:Int) -> Int
    func cellForRowAt(_ indexPath:IndexPath) -> (identifier:String,icon:String,title:String,subTitle:String,connectionStatus:String)
    func didSelectRowAt(_ indexPath:IndexPath)
    func viewDidLoad()
    func searchDeviceAgain()
}

protocol MenuUseCase: class {
    // TODO: Declare use case methods
    func searchDevices()
    func getDevices()
    func connectDevice(at indexPath:IndexPath)
}

protocol MenuInteractorOutput: class {
    // TODO: Declare interactor output methods
    func didFetched(devices:[Device])
    func didConnected(device:Device)
    func didNotFetched(with message:String)
}

protocol MenuWireframe: class {
    // TODO: Declare wireframe methods
}
