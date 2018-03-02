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
    func cast() {
        manager.stop { (isSuccess, error) in
            casting()
        }
        func casting(){
            manager.castVideo(for: video){ (isSuccess, error) in
                if let err = error {
                    self.output?.failureCasted(with: err)
                    return
                }
                guard isSuccess else {return}
                self.output?.didCasted()
            }
        }
        
    }
    
    func remotePlay() {
        manager.play { (isSuccess, error) in
            if isSuccess {self.output?.didRemotePlayed()}
        }
    }
    
    func remoteSeek(at time: TimeInterval) {
        manager.seek(at: time.parseDuration2()) { (isSuccess, error) in
            if isSuccess {self.output?.didRemoteSeeked()}
        }
    }
    
    func remoteStop() {
        manager.stop { (isSuccess, error) in
            if isSuccess {self.output?.didRemoteStoped()}
        }
    }
    
    func remotePause() {
        manager.pause { (isSuccess, error) in
            if isSuccess {self.output?.didRemotePaused()}
        }
    }
    
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
    
}
