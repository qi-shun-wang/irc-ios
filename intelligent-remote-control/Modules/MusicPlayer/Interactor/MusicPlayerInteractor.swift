//
//  MusicPlayerInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MusicPlayerInteractor {

    // MARK: Properties

    weak var output: MusicPlayerInteractorOutput? {
        didSet {
            output?.update(song: song)
        }
    }
    
    let dlnaManager:DLNAMediaManager
    let song:Song
    
    init(dlnaManager:DLNAMediaManagerProtocol,song: Song) {
        self.song = song
        self.dlnaManager = dlnaManager as! DLNAMediaManager
//        self.dlnaManager.delegate = self
        
        
    }
}

extension MusicPlayerInteractor: MusicPlayerUseCase {
    // TODO: Implement use case methods
}
