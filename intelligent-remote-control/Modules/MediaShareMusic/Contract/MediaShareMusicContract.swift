//
//  MediaShareMusicContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MediaShareMusicView: BaseView {
    // TODO: Declare view methods
    //segment control
    func setupSegment()
    //collection view
    func setupPlaylistTableView(tag: Int)
    func setupSongsTableView(tag: Int)
    func showAlbumsCollectionView()
    func showSongsTableView()
    func showPlaylistTableView()
    func fetchedPhotoSize() -> Size?
    
    func reloadAlbumsCollectionView()
    func reloadSongsTableView()
    func reloadPlaylistTableView()
    
    func showTips()
    func hideTips()
}

protocol MediaShareMusicPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func switchOnSegment(at index:Int)
    func showDMRList()
    func stopMusicCast()
    func didSelectRow(about tag:Int, at indexPath: IndexPath)
    func numberOfRows(about tag:Int, in section:Int) -> Int
    func cellInfo(about tag:Int ,at indexPath:IndexPath) ->
        (title:String,subtitle:String,image:Image?)
    
    func didSelectItem(at indexPath: IndexPath)
    func numberOfItems(in section:Int) -> Int
    func itemInfo(at indexPath:IndexPath) -> (title:String,subtitle:String,image:Image?)
    
    func setupAssetFetchOptions()
    func navigateBack()
}

protocol MediaShareMusicUseCase: class {
    
    func stopCasting()
    func checkMusicPermission()
    func fetchMusicPlaylists()
    func fetchMusicSongs()
    func fetchMusicAlbums()
}

protocol MediaShareMusicInteractorOutput: class {
    // TODO: Declare interactor output methods
    func fetchedMusicPlaylists(_ playlists:[Playlist])
    func fetchedMusicSongs(_ songs:[Song])
    func fetchedMusicAlbums(_ albums:[Album])
    func failureAuthorizedPermission()
    func successAuthorizedPermission()
}

protocol MediaShareMusicWireframe: class {
    // TODO: Declare wireframe methods
    func pushMusicList(_ song: Song)
    func pushMusicList(_ album:Album)
    func pushMusicList(_ playlist:Playlist)
    func navigateBack()
}

protocol Playlist {
    var playlistName:String{get}
    var songs:[Song]{get}
    var artworkImage:Image?{get}
}
protocol Album {
    var albumName:String{get}
    var songs:[Song]{get}
    var artistName:String{get}
    var artworkImage:Image?{get}
}
protocol Song {
    var name:String{get}
    var artistName:String{get}
    var albumName:String{get}
    var artworkImage:Image?{get}
    var songURL:URL? {get}
    var duration:TimeInterval?{get}
}
