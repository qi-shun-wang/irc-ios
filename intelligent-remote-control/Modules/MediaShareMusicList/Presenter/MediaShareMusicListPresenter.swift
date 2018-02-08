//
//  MediaShareMusicListPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareMusicListPresenter {
    
    // MARK: Properties
    
    weak var view: MediaShareMusicListView?
    var router: MediaShareMusicListWireframe?
    var interactor: MediaShareMusicListUseCase?
    fileprivate var songs:[Song] = []
}

extension MediaShareMusicListPresenter: MediaShareMusicListPresentation {
    
    // TODO: implement presentation methods
    func didSelectRow(at indexPath: IndexPath) {
            let song = songs[indexPath.row]
            router?.pushMusicPlayer(song)
        
        
    }
    
    func numberOfRows(in section: Int) -> Int {
        return songs.count
    }
    
    func cellInfo(at indexPath: IndexPath) -> (title: String, subtitle: String, image: Image?) {
        let song = songs[indexPath.row]
        return (song.name,song.artistName,song.artworkImage)
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupNavigationLeftItem(image: "navigation_back_icon", title: interactor?.getAlbumName() != nil ? "專輯":"播放清單")
        let navigationTitle:String = interactor?.getAlbumName() ?? interactor?.getPlaylistName() ?? ""
        view?.setupNavigationBarTitle(with: navigationTitle)
        interactor?.fetchMusicSongs()
    }
    
}

extension MediaShareMusicListPresenter: MediaShareMusicListInteractorOutput {
    
    // TODO: implement interactor output methods
    func fetchedMusicSongs(_ songs: [Song]) {
        self.songs = songs
        view?.reloadSongsTableView()
    }
    
    func navigateBack() {
        router?.navigateBack()
    }
    
}
