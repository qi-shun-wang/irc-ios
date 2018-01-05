//
//  MediaSharePhotosInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaSharePhotosInteractor {

    // MARK: Properties
    weak var dlnaManager:DLNAMediaManagerProtocol?
    weak var output: MediaSharePhotosInteractorOutput?
}

extension MediaSharePhotosInteractor: MediaSharePhotosUseCase {
    // TODO: Implement use case methods
    func castSelectedImage(_ asset: ImageAsset) {
        dlnaManager?.castImage(for: asset)
        
    }
}
