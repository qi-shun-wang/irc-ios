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
    let album:Album?
    let playlist:Playlist?
    
    init(with album:Album) {
        self.album = album
        self.playlist = nil
    }
    
    init(with playlist:Playlist) {
        self.playlist = playlist
        self.album = nil
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
