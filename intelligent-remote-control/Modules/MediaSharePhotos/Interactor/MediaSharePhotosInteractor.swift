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
    private var selectedAssets:[ImageAsset] = []
}

extension MediaSharePhotosInteractor: MediaSharePhotosUseCase {
   
    func setupSelectedPhotos(assets: [ImageAsset]) {
        selectedAssets = assets
    }
    
    func setupCurrentRemoteAsset(at index: Int) {
        
        dlnaManager?.castImage(for: selectedAssets[index], { (isSuccess, error) in
            isSuccess ? self.output?.didSetRemoteAssetSuccess() : self.output?.didSetRemoteAssetFailure()
        })
    }
    
    func performRemotePlay() {
        dlnaManager?.play { (isSuccess, error) in
            isSuccess ? self.output?.didPlayRemoteAssetSuccess() :self.output?.didPlayRemoteAssetFailure()
        }
    }
    
    func performRemoteStop() {
        dlnaManager?.stop({ (isSuccess, error) in
            isSuccess ? () : self.output?.didStopRemoteAssetFailure()
        })
    }
    
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
}
