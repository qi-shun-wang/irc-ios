//
//  MediaShareMusicPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareMusicPresenter {

    // MARK: Properties

    weak var view: MediaShareMusicView?
    var router: MediaShareMusicWireframe?
    var interactor: MediaShareMusicUseCase?
    
    fileprivate var playlists:[Playlist] = []
    fileprivate var songs:[Song] = []
    fileprivate var albums:[Album] = []
}

extension MediaShareMusicPresenter: MediaShareMusicPresentation {
    
    // TODO: implement presentation methods
    func switchOnSegment(at index: Int) {
        guard let type = MusicCollectionType(rawValue: index) else {return}
        switch type {
        case .albums: view?.showAlbumsCollectionView()
        case .playlist: view?.showPlaylistTableView()
        case .songs: view?.showSongsTableView()
        }
    }
    
    func showDMRList() {
        
    }
    
    func didSelectRow(about tag: Int, at indexPath: IndexPath) {
        guard let type = MusicCollectionType(rawValue: tag) else {return}
        switch type {
        case .songs:
            let selectedSong = songs[indexPath.row]
            interactor?.castSelectedSong(selectedSong)
        default :break
        }
    }
    
    func numberOfRows(about tag: Int, in section: Int) -> Int {
        guard let type = MusicCollectionType(rawValue: tag) else {return 0}
        switch type {
        case .playlist: return playlists.count
        case .songs: return songs.count
        default :return 0
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }
    
    func numberOfItems(in section: Int) -> Int {
        return albums.count
    }
    
    func cellInfo(about tag: Int, at indexPath: IndexPath) -> (title: String, subtitle: String, image: Image?) {
        guard let type = MusicCollectionType(rawValue: tag) else {return ("","",nil)}
        switch type {
        case .playlist:
            let playlist = playlists[indexPath.row]
            return (playlist.playlistName,"\(playlist.songs.count) songs",playlist.artworkImage)
        case .songs:
            let song = songs[indexPath.row]
            return (song.name,song.artistName,song.artworkImage)
        default :return ("","",nil)
        }
    }
    
    func itemInfo(at indexPath: IndexPath) -> (title: String, subtitle: String, image: Image?) {
        let album = albums[indexPath.row]
        return (album.albumName,album.artistName,album.artworkImage)
    }
    
    func setupAssetFetchOptions() {
        
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupSegment()
        view?.setupPlaylistTableView(tag: MusicCollectionType.playlist.rawValue)
        view?.setupSongsTableView(tag: MusicCollectionType.songs.rawValue)
        interactor?.fetchMusicPlaylists()
        interactor?.fetchMusicSongs()
        interactor?.fetchMusicAlbums()
    }
    
}

extension MediaShareMusicPresenter: MediaShareMusicInteractorOutput {
   
    // TODO: implement interactor output methods
    func fetchedMusicAlbums(_ albums: [Album]) {
        self.albums = albums
        view?.reloadAlbumsCollectionView()
    }
    
    func fetchedMusicSongs(_ songs: [Song]) {
        self.songs = songs
        view?.reloadSongsTableView()
    }
    
    func fetchedMusicPlaylists(_ playlists: [Playlist]) {
        self.playlists = playlists
        view?.reloadPlaylistTableView()
    }
    
}
