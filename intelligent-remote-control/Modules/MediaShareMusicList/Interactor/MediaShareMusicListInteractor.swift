//
//  MediaShareMusicListInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareMusicListInteractor {

    // MARK: Properties
    
    weak var output: MediaShareMusicListInteractorOutput?
    let dlnaManager:DLNAMediaManagerProtocol
    let album:Album
   
    init(dlnaManager:DLNAMediaManagerProtocol,with album:Album) {
        self.dlnaManager = dlnaManager
        self.album = album
    }
}

extension MediaShareMusicListInteractor: MediaShareMusicListUseCase {
    
    // TODO: Implement use case methods
    func fetchMusicSongs() {
        output?.fetchedMusicSongs(album.songs)
    }
    
    func castSelectedSong(_ song: Song) {
        guard let assetURL = song.songURL else {return}
        dlnaManager.castSong(for: assetURL)
    }
    func getAlbumName() -> String {
        return album.albumName
    }
}
