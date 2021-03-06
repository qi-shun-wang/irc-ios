//
//  MediaShareMusicInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import MediaPlayer

class MediaShareMusicInteractor {
    
    // MARK: Properties
    lazy var queryPlaylists:MPMediaQuery = MPMediaQuery.playlists()
    lazy var querySongs:MPMediaQuery = MPMediaQuery.songs()
    lazy var queryAlbums:MPMediaQuery = MPMediaQuery.albums()
    weak var output: MediaShareMusicInteractorOutput?
    
    let dlnaManager:DLNAMediaManagerProtocol
    
    init(dlnaManager:DLNAMediaManagerProtocol) {
        self.dlnaManager = dlnaManager
    }
    
 
}

extension MediaShareMusicInteractor: MediaShareMusicUseCase {
    
    func checkMusicPermission() {
        MPMediaLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                 self.output?.successAuthorizedPermission()
            default:
                 self.output?.failureAuthorizedPermission()
            }
        }
    }
    
    func stopCasting() {
        dlnaManager.stop { (isSuccess, error) in
            //TODO:notify to presentor when casting stopped success or fail
        }
    }
    func fetchMusicAlbums() {
        let albums:[MPMediaItemCollection] = queryAlbums.collections ?? []
        output?.fetchedMusicAlbums(albums)
    }
    
    func fetchMusicSongs() {
        let songs:[MPMediaItem] = querySongs.items ?? []
        output?.fetchedMusicSongs(songs)
    }
    
    func fetchMusicPlaylists() {
        let playlists:[MPMediaItemCollection] = queryPlaylists.collections ?? []
        output?.fetchedMusicPlaylists(playlists)
    }
    
    
}
