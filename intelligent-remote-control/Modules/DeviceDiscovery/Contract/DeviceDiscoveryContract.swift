//
//  DeviceDiscoveryContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/30.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol DeviceDiscoveryView: BaseView {
    // TODO: Declare view methods
    func setupAnimationImages()
    func startConnectingAnimation()
    func stopConnectingAnimation()
    func startSearchingAnimation()
    func stopSearchingAnimation()
    func reloadCollectionView()
    func startAnimation(at x:Float,_ y:Float,with w:Float,_ h:Float)
    func setupSelectedDeviceName(text:String)
    func setupHeaderTitle(text:String)
    func setupConnectionMessage(text:String)
    func showConnectedSuccess()
    func showDeviceNotFound(with text:String)
    func showConnectedFailure(with text:String)
}

protocol DeviceDiscoveryPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func dissmiss()
    func didSelectItem(at indexPath:IndexPath)
    func numberOfItems(in section:Int) -> Int
    func cellForItem(at indexPath:IndexPath) -> (deviceTitle:String,deviceIconName:String)
    func setStartAnimation(at x:Float,_ y:Float,with w:Float,_ h:Float)
    func performDeviceConnection()
    func performDeviceSearch()
}

protocol DeviceDiscoveryUseCase: class {
    // TODO: Declare use case methods
    func startSearch()
    func stopSearch()
    func getDevices()
    func select(device:Device)
    func playSoundEffect()
    func playSuccessSoundEffect()
    func clearCached()
}

protocol DeviceDiscoveryInteractorOutput: class {
    // TODO: Declare interactor output methods
    func failureConnection()
    func didFetched(devices: [Device])
    func didConnected(device: Device)
    func didDisconnected()
    func didFoundDevice()
    func deviceNotFound()
}

protocol DeviceDiscoveryWireframe: class {
    // TODO: Declare wireframe methods
     func dismissDeviceDiscovery()
}
