//
//  MediaShareVideosInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/6.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareVideosInteractor {

    // MARK: Properties
    weak var dlnaManager:DLNAMediaManagerProtocol?
    weak var output: MediaShareVideosInteractorOutput?
}

extension MediaShareVideosInteractor: MediaShareVideosUseCase {
    func checkConnectionStatus() {
        guard let device = dlnaManager?.getCurrentDevice() else {
            output?.deviceNotConnect()
            return
        }
        output?.didConnected(device)
    }
    
    func castSelectedVideo(_ asset: VideoAsset) {
        output?.didStartCasting()
        dlnaManager?.castVideo(for: asset, { (isSuccess, error) in
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
