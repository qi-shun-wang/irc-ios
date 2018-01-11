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
    let album:Album?
    let playlist:Playlist?
    
    init(dlnaManager:DLNAMediaManagerProtocol,with album:Album) {
        self.dlnaManager = dlnaManager
        self.album = album
        self.playlist = nil
    }
    
    init(dlnaManager:DLNAMediaManagerProtocol,with playlist:Playlist) {
        self.dlnaManager = dlnaManager
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
    
    func castSelectedSong(_ song: Song) {
        guard let assetURL = song.songURL else {return}
        dlnaManager.castSong(for: assetURL)
    }
    
    func getAlbumName() -> String? {
        return album?.albumName
    }
    
    func getPlaylistName() -> String? {
        return playlist?.playlistName
    }
    
}
