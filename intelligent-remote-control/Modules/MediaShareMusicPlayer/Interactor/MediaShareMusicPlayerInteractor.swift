//
//  MediaShareMusicPlayerInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareMusicPlayerInteractor {

    // MARK: Properties

    weak var output: MediaShareMusicPlayerInteractorOutput?
    let dlnaManager:DLNAMediaManagerProtocol
    let song:Song
    
    init(dlnaManager:DLNAMediaManagerProtocol,song: Song) {
        self.song = song
        self.dlnaManager = dlnaManager
    }
}

extension MediaShareMusicPlayerInteractor: MediaShareMusicPlayerUseCase {
    
    // TODO: Implement use case methods
    func fetchMusicDetail(){
        output?.fetchedMusicDetail(songName: song.name, artistName: song.artistName, image: song.artworkImage)
    }
    
    func castMusic() {
        guard let assetURL = song.songURL else {return}
        dlnaManager.castSong(for: assetURL)
    }
}
