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
     
    func stopCasting() {
        dlnaManager?.stop({ (isSuccess, error) in
            if isSuccess{self.output?.didStopedCasting()}
        })
    }
}
