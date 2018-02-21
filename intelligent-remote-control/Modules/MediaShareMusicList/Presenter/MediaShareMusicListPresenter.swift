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
    fileprivate var isBadgePresented:Bool = false
}

extension MediaShareMusicListPresenter: MediaShareMusicListPresentation {
    
    // TODO: implement presentation methods
    func didSelectRow(at indexPath: IndexPath) {
        guard (songs[indexPath.row].songURL) != nil else {
            view?.showWarningBadge(with: "此項目為Apple Music權限限制，無法在此播放！")
            isBadgePresented = true
            return
        }
        if isBadgePresented {
            isBadgePresented = false
            view?.hideWarningBadge(with: "準備播放...")
        }
        
        router?.pushMusicPlayer(with: songs, at: indexPath.row) 
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
        view?.setupWarningBadge()
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
