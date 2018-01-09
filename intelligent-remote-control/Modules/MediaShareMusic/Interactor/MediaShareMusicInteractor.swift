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
}

extension MediaShareMusicInteractor: MediaShareMusicUseCase {
    
    func fetchMusicAlbums() {
        let albums:[MPMediaItemCollection] = queryAlbums.collections ?? []
        output?.fetchedMusicAlbums(albums)
    }
    
    func fetchMusicSongs() {
        let songs:[MPMediaItem] = querySongs.items ?? []
        output?.fetchedMusicSongs(songs)
    }
    
    
    // TODO: Implement use case methods
    func fetchMusicPlaylists() {
        let playlists:[MPMediaItemCollection] = queryPlaylists.collections ?? []
        output?.fetchedMusicPlaylists(playlists)
    }
    
}

extension MPMediaItemCollection {
    
    func getPlaylistName() -> String {
        return self.value(forProperty: MPMediaPlaylistPropertyName) as? String ?? "No Name"
    }
    
    func getArtworkImage(size:CGSize) -> Image? {
        return self.representativeItem?.artwork?.image(at: size)
    }
    
    func getSongs()->[Song]{
        return self.items
    }
    
    func getAlbumArtistName() -> String {
        return self.representativeItem?.albumArtist  ?? "No Name"
    }
    
    func getAlbumName() -> String {
        return self.representativeItem?.albumName  ?? "No Name"
    }
    
}

extension MPMediaItem {
    
    func getSongName() -> String {
        return self.value(forProperty: MPMediaItemPropertyTitle) as? String ?? "No Name"
    }
    
    func getArtistName() -> String {
        return self.value(forProperty: MPMediaItemPropertyArtist) as? String ?? "No Name"
    }
    
    func getAlubmName() -> String {
        return self.value(forProperty: MPMediaItemPropertyAlbumTitle) as? String ?? "No Name"
    }
    
    func getArtworkImage(size:CGSize) -> Image? {
        return self.artwork?.image(at:size)
    }
    
}

extension MPMediaItem:Song {
    
    var name: String {
        get {return getSongName()}
    }
    
    var artistName: String {
        get {return getArtistName()}
    }
    
    var albumName: String {
        get {return getAlubmName()}
    }
    
    var artworkImage: Image? {
        get {return getArtworkImage(size:CGSize(width: 100, height: 100))}
    }
    
}

extension MPMediaItemCollection:Playlist,Album {
    
    var artistName: String {
        get {return getAlbumArtistName()}
    }
    
    var songs: [Song] {
        get {return getSongs()}
    }
    
    var artworkImage: Image? {
        get {return getArtworkImage(size:CGSize(width: 100, height: 100))}
    }
    
    var albumName: String {
        get {
            return getAlbumName()
        }
    }
    
    var playlistName: String {
        get {
            return getPlaylistName()
        }
    }
    
}
