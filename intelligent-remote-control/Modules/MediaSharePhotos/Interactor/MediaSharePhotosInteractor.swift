//
//  MediaSharePhotosInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import Photos

class MediaSharePhotosInteractor {

    // MARK: Properties
    weak var dlnaManager:DLNAMediaManagerProtocol?
    weak var output: MediaSharePhotosInteractorOutput?
}

extension MediaSharePhotosInteractor: MediaSharePhotosUseCase {

    func checkPhotoPermission() {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.output?.successAuthorizedPermission()
            default:
                self.output?.failureAuthorizedPermission()
            }
        }
    }
    
    func checkConnectionStatus() {
        guard let device = dlnaManager?.getCurrentDevice() else {
            output?.deviceNotConnect()
            return
        }
        output?.didConnected(device)
    }
    
    func castSelectedImage(_ asset:ImageAsset){
       
        output?.didStartCasting()
        dlnaManager?.castImage(for: asset, { (isSuccess, error) in
            if isSuccess {
                self.output?.willStartNext()
            }
        })
        
    }
    
    func stopCasting() {
        dlnaManager?.stop({ (isSuccess, error) in
            if isSuccess{self.output?.didStopedCasting()}
        })
    }
}
