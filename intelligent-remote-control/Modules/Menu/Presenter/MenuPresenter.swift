//
//  MenuPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuPresenter {
    fileprivate let MenuCellIdentifier = "MenuCell"
    // MARK: Properties
    fileprivate let fiveSecond = 5.0
    weak var view: MenuView?
    var router: MenuWireframe?
    var interactor: MenuUseCase?
    
    fileprivate var items:[MenuModel] = [] {
        didSet {
            view?.updateMenuTable()
        }
        
    }
    lazy fileprivate var worker:Worker = Worker(durationOf:fiveSecond, repeatedAction: repeatedFetchAction)
    lazy var repeatedFetchAction:(()->Void) = {
        self.interactor?.getDevices()
        self.worker.isPlaying = false
    }
    
}

extension MenuPresenter: MenuPresentation {
    // TODO: implement presentation methods
    
    func viewDidLoad() {
//        interactor?.searchDevices()
//        worker.isPlaying = true
    }
    
    func numberOfRowsInSection(_ section:Int) -> Int {
        return items.count
    }
    
    func cellForRowAt(_ indexPath:IndexPath) -> (identifier:String,icon:String,title:String,subTitle:String,connectionStatus:String) {
        let item = items[indexPath.row]
        let data = (MenuCellIdentifier,item.iconName,item.title,item.subTitle,item.connectionStatus)
        return data
    }
    
    func searchDeviceAgain() {
        worker.isPlaying = true
    }
    
    func didSelectRowAt(_ indexPath:IndexPath){
        interactor?.connectDevice(at: indexPath)
    }
}

extension MenuPresenter: MenuInteractorOutput {
    
    // TODO: implement interactor output methods
    func didFetched(devices: [Device]) {
        var menu:[MenuModel] = []
        devices.forEach { (device ) in
            menu.append((device as! KODConnection).getModel())
        }
        items = menu
    }
    
    func didNotFetched(with message: String) {
        
    }
    func didConnected(device: Device) {
        
    }
}
