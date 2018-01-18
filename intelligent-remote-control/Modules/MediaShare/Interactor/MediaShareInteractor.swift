//
//  MediaShareInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
enum WifiConnectedError:MediaShareError{
    case notConnectedToWifi
}
class MediaShareInteractor {
    
    // MARK: Properties
    
    weak var output: MediaShareInteractorOutput?
   
    let dlnaManager:DLNAMediaManagerProtocol
    
    init(dlnaManager:DLNAMediaManagerProtocol) {
        self.dlnaManager = dlnaManager
        NotificationCenter.default.addObserver(self, selector: #selector(MediaShareInteractor.networkStatusChanged(_:)), name: NSNotification.Name(rawValue: ReachabilityStatusChangedNotification), object: nil)
        Reach().monitorReachabilityChanges()
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        let userInfo = (notification as NSNotification).userInfo
        print(userInfo as Any)
        do{
            try checkNetworkStatus()
            dlnaManager.startServer()
            output?.wifiReconnectedSuccess()
        } catch {
            print(error)
            output?.wifiConnectedError(WifiConnectedError.notConnectedToWifi)
            
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension MediaShareInteractor: MediaShareUseCase {
    
    // TODO: Implement use case methods
    func fetchTableList() {
        
        let list:[IndexPath:MediaShareTypeProtocol] = [
            IndexPath(row: 0, section: 0):MediaShareType.localMusic,
            IndexPath(row: 1, section: 0):MediaShareType.localPhotos,
            IndexPath(row: 0, section: 1):MediaShareType.remoteGoogle,
            IndexPath(row: 1, section: 1):MediaShareType.remoteFacebook,
            IndexPath(row: 2, section: 1):MediaShareType.remoteInstagram,
            IndexPath(row: 3, section: 1):MediaShareType.remoteDropbox,
            ]
        output?.tableListFetched(list)
    }
    
    func fetchCurrentDMR() {
        output?.currentDMRFetched(dlnaManager.getCurrentDevice())
    }
    
    func checkNetworkStatus() throws {
        
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline ,.online(.wwan):
            throw WifiConnectedError.notConnectedToWifi
        case .online(.wiFi):
            print("Connected via WiFi")
        }
    }
    
}
