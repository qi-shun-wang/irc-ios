//
//  MediaShareInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareInteractor {
    
    // MARK: Properties
    
    weak var output: MediaShareInteractorOutput?
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
    
}
