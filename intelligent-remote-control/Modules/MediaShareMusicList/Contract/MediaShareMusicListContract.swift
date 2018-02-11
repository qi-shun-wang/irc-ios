//
//  MediaShareMusicListContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MediaShareMusicListView: BaseView {
    // TODO: Declare view methods
    func reloadSongsTableView()
    func setupToolBarLeftItem(image named: String, title text: String)
    func setupNavigationBarTitle(with text:String)
}

protocol MediaShareMusicListPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func didSelectRow(at indexPath: IndexPath)
    func numberOfRows(in section:Int) -> Int
    func cellInfo(at indexPath:IndexPath) -> (title:String,subtitle:String,image:Image?)
    func navigateBack()
}

protocol MediaShareMusicListUseCase: class {
    // TODO: Declare use case methods
    func fetchMusicSongs()
    func getAlbumName() -> String?
    func getPlaylistName() -> String?
    func castSelectedSong(_ song:Song)
    
}

protocol MediaShareMusicListInteractorOutput: class {
    // TODO: Declare interactor output methods
    func fetchedMusicSongs(_ songs:[Song])
}

protocol MediaShareMusicListWireframe: class {
    // TODO: Declare wireframe methods
    func navigateBack()
    func pushMusicPlayer(with playlist:[Song],at index:Int)
}
