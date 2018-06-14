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
    let album: Album?
    let playlist: Playlist?
    let manager: DLNAMediaManagerProtocol?
    
    init(with album:Album, _ manager:DLNAMediaManagerProtocol) {
        self.album = album
        self.playlist = nil
        self.manager = manager
    }
    
    init(with playlist:Playlist, _ manager:DLNAMediaManagerProtocol) {
        self.playlist = playlist
        self.album = nil
        self.manager = manager
    }
}

extension MediaShareMusicListInteractor: MediaShareMusicListUseCase {
    
    // TODO: Implement use case methods
    func fetchMusicSongs() {
        if let songs = album?.songs {
            output?.fetchedMusicSongs(songs)
            return
        }
        
        if let songs = playlist?.songs {
            output?.fetchedMusicSongs(songs)
        }
      
    }
    
    func getAlbumName() -> String? {
        return album?.albumName
    }
    
    func getPlaylistName() -> String? {
        return playlist?.playlistName
    }
    
}
