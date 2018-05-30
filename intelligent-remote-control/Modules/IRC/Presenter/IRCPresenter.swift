//
//  IRCPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class IRCPresenter {
    
    // MARK: Properties
    weak var view: IRCView?
    var router: IRCWireframe?
    var interactor: IRCUseCase?
    private var device: Device?
}

extension IRCPresenter: IRCPresentation {
   
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func performAction(state: PerformState, with sendCode: SendCode) {
        interactor?.perform(state: state, sendevent: sendCode)
    }
    
    func viewDidLoad() {
        interactor?.startWiFiMonitor()
    }
    
    func performLongAction(with sendCode: SendCode) {
        interactor?.performLong(sendevent: sendCode)
    }
   
    func performAction(with keyCode: KeyCode) {
        interactor?.perform(keyevent: keyCode)
    }
    
    func performInput(text:String){
        interactor?.perform(input: text)
    }
    
    func performMotion(with dx: Float, _ dy: Float) {
        let delta:Float = 10
        if dx > 0 && dy > 0 {
            if dx * delta > dy {
                //3
                interactor?.perform(motion: "3")
            }else if dy * delta > dx {
                interactor?.perform(motion: "5")
                //5
            }else {
                //4
                interactor?.perform(motion: "4")
            }
            //345
        }
        if dx > 0 && dy < 0 {
            //12
            interactor?.perform(motion: "12")
        }
        if dx < 0 && dy > 0 {
            interactor?.perform(motion: "67")
            //67
        }
        if dx < 0 && dy < 0 {
            //8
            interactor?.perform(motion: "8")
        }
        
    }
    
    func presentDeviceDiscovery() {
        router?.presentDeviceDiscovery()
    }
    
    func updateConnectionStatus() {
        interactor?.getCurrentConnectedDevice()
    }
}

extension IRCPresenter: IRCInteractorOutput {
    
    func didNotConnectedWiFi() {
        view?.setupNavigationLeftItem(image: "device_disconnect_icon", title: " 尚未連接WiFi")
        view?.showWarningBadge(with: "尚未連接WiFi，請到設定>WiFi>開啟WiFi")
    }
    
    func didConnectedWiFi() {
        view?.hideWarningBadge(with:"已經連上WiFi")
        view?.setupNavigationLeftItem(image: "device_disconnect_icon", title: " 尚未連接到設備")
        if let device = device {
            view?.setupNavigationLeftItem(image: "device_disconnect_icon", title: " 已連結到：\(device.name)")
        }
        
    }
    
    // TODO: implement interactor output methods
    func successConnected(device: Device) {
        self.device = device
        view?.setupNavigationLeftItem(image: "device_connect_icon", title: " 已連結到：\(device.name)")
    }
    
    func failureConnected() {
        view?.setupNavigationLeftItem(image: "device_disconnect_icon", title: " 尚未連接到設備")
    }
}
