//
//  MediaShareVideoPlayerInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import Photos

class MediaShareVideoPlayerInteractor {
    
    // MARK: Properties
    let manager:DLNAMediaManagerProtocol!
    weak var output: MediaShareVideoPlayerInteractorOutput?
    
    var video:PHAsset
    
    init(dlnaManager:DLNAMediaManagerProtocol,with video:VideoAsset) {
        self.manager = dlnaManager
        self.video = video as! PHAsset
    }
    
    func load(asset:PHAsset) {
        
        PHCachingImageManager().requestAVAsset(forVideo: asset, options: nil) { (avAsset, _, _) in
            DispatchQueue.main.async {
                if let avAsset = avAsset {
                    self.output?.didLoad(avAsset)
                }
            }
        }
    }
}

extension MediaShareVideoPlayerInteractor: MediaShareVideoPlayerUseCase {
    
    func fetchAsset(){
        load(asset: video)
    }
    
    func fetchCurrentDevice() {
        guard let device = manager.getCurrentDevice() else {
            output?.playLocalDevice()
            return
        }
        output?.playRemoteDevice(device)
    }
    
    func setupCurrentRemoteAsset() {
        manager.castVideo(for: video){ (isSuccess, error) in
            isSuccess ? self.output?.didSetRemoteAssetSuccess() :self.output?.didSetRemoteAssetFailure()
        }
    }
    
    func performRemotePlay() {
        manager.play { (isSuccess, error) in
            isSuccess ? self.output?.didPlayRemoteAssetSuccess() :self.output?.didPlayRemoteAssetFailure()
        }
    }
    
    func performRemoteStop() {
        manager.stop { (isSuccess, error) in
            isSuccess ? () : self.output?.didStopRemoteAssetFailure()
        }
    }
    
    func performRemotePause() {
        manager.pause { (isSuccess, error) in
            isSuccess ? self.output?.didPauseRemoteAssetSuccess():self.output?.didPauseRemoteAssetFailure()
        }
    }
    
    func performRemoteSeek(at time: TimeInterval) {
        manager.seek(at: time.parseDuration()) { (isSuccess, error) in
            isSuccess ? self.output?.didSeekRemoteAssetSuccess():self.output?.didSeekRemoteAssetFailure()
        }
    }
    
    func fetchRemoteTimeInterval() {
        manager.fetchCurrentTimeInterval { (timeInterval, error) in
            
            if error == nil {
                self.output?.didFetchRemoteTimeSuccess(seconds: timeInterval)
            }else{
                self.output?.didFetchRemoteTimeFailure()
            }
        }
    }
}
