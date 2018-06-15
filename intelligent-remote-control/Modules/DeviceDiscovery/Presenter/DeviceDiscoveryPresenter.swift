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
    fileprivate var shouldPlayAgainSoundEffect:Bool = true
    fileprivate var devices:[KODConnection] = []
    
}

extension DeviceDiscoveryPresenter: DeviceDiscoveryPresentation {
    
    func viewWillAppear() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: Notification.Name.UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
        
    }
    
    @objc func appDidBecomeActive(){
        devices = []
        view?.startSearchingAnimation()
        interactor?.startSearch()
        view?.reloadCollectionView()
    }
    
    @objc func appWillResignActive(){
        devices = []
        shouldPlayAgainSoundEffect = true
        view?.stopSearchingAnimation()
        view?.stopConnectingAnimation()
        interactor?.stopSearch()
        view?.reloadCollectionView()
    }
    
    func viewWillDisappear() {
        NotificationCenter.default.removeObserver(self)
    }
    
    func dissmiss() {
        interactor?.clearCached()
        router?.dismissDeviceDiscovery()
    }
    
    func viewDidLoad() {
        view?.setupAnimationImages()
        view?.startSearchingAnimation()
        interactor?.clearCached()
        devices = []
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
        return (device.name, "menu_device_white_icon")
    }
    
    func setStartAnimation(at x: Float, _ y: Float, with w: Float, _ h: Float) {
        view?.startAnimation(at: x, y, with: w, h)

    }
    func performDeviceConnection(){
        interactor?.stopSearch()
        view?.stopSearchingAnimation()
        view?.startConnectingAnimation()
    }
    
    func performDeviceSearch() {
        view?.startSearchingAnimation()
        interactor?.startSearch()
    }
}

extension DeviceDiscoveryPresenter: DeviceDiscoveryInteractorOutput {
    
    func deviceNotFound() {
        view?.stopConnectingAnimation()
        view?.stopSearchingAnimation()
        view?.showDeviceNotFound(with: "找不到設備")
    }
    func failureConnection() {
        view?.stopConnectingAnimation()
        view?.stopSearchingAnimation()
        view?.showConnectedFailure(with: "連結失敗")
    }
    func didDisconnected() {
        
    }
    
    func didConnected(device: Device) {
        let when = DispatchTime.now() + 3 // desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.view?.stopConnectingAnimation()
            self.view?.setupConnectionMessage(text: "已連結成功")
            self.view?.showConnectedSuccess()
            self.interactor?.playSuccessSoundEffect()
            let when = DispatchTime.now() + 3 // desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
               self.router?.dismissDeviceDiscovery()
            }
        }
    }
    
    func didFetched(devices: [Device]) {
        self.devices = devices as! [KODConnection]
        interactor?.stopSearch()
        view?.stopSearchingAnimation()
        view?.stopConnectingAnimation()
        view?.reloadCollectionView()
        if shouldPlayAgainSoundEffect {
            interactor?.playSoundEffect()
            self.shouldPlayAgainSoundEffect = false
        }
    }
  
    func didFoundDevice() {
        let when = DispatchTime.now() + 3 // desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.interactor?.getDevices()
            
        }
    }
}
