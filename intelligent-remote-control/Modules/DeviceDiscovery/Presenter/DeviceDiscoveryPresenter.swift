//
//  DeviceDiscoveryPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/30.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class DeviceDiscoveryPresenter {

    // MARK: Properties

    weak var view: DeviceDiscoveryView?
    var router: DeviceDiscoveryWireframe?
    var interactor: DeviceDiscoveryUseCase?
    
    fileprivate var devices:[KODConnection] = []
    
}

extension DeviceDiscoveryPresenter: DeviceDiscoveryPresentation {
    
    // TODO: implement presentation methods
    func dissmiss() {
        router?.dismissDeviceDiscovery()
    }
    
    func viewDidLoad() {
        view?.setupAnimationImages()
        view?.startSearchAnimating()
        interactor?.startSearch()
        view?.reloadCollectionView()
        view?.setupHeaderTitle(text: "正在搜尋KOD+")
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
        let device = devices[indexPath.item]
        interactor?.select(device: device)
        view?.setupSelectedDeviceName(text: device.name)
    }
    
    func numberOfItems(in section: Int) -> Int {
        return devices.count
    }
    
    func cellForItem(at indexPath: IndexPath) -> (deviceTitle: String, deviceIconName: String) {
        let device = devices[indexPath.item]
        return (device.name,"menu_device_white_icon")
    }
    
    func setStartAnimation(at x: Float, _ y: Float, with w: Float, _ h: Float) {
        view?.startAnimation(at: x, y, with: w, h)

    }
    func startConnection(){
        view?.startConnectionAnimating()
    }
}

extension DeviceDiscoveryPresenter: DeviceDiscoveryInteractorOutput {
    // TODO: implement interactor output methods
    func didConnected(device: Device) {
        let when = DispatchTime.now() + 3 // desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.stopConnectionAnimating()
            self.view?.setupConnectionMessage(text: "已連結成功")
            self.interactor?.playSoundEffect()
            let when = DispatchTime.now() + 3 // desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
               self.router?.dismissDeviceDiscovery()
            }
        }
    }
    
    func didFetched(devices: [Device]) {
        self.devices = devices as! [KODConnection]
        interactor?.stopSearch()
        view?.stopSearchAnimating()
        view?.reloadCollectionView()
        
    }
    
    func hasFound() {
        let when = DispatchTime.now() + 3 // desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.interactor?.getDevices()
            self.interactor?.playSoundEffect()
        }
    }
}
