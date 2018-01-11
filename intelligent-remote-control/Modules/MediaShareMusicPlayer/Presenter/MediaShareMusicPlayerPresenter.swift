//
//  MediaShareMusicPlayerPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareMusicPlayerPresenter {
    
    // MARK: Properties
    
    weak var view: MediaShareMusicPlayerView?
    var router: MediaShareMusicPlayerWireframe?
    var interactor: MediaShareMusicPlayerUseCase?
}

extension MediaShareMusicPlayerPresenter: MediaShareMusicPlayerPresentation {
    
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupNavigationLeftItem(image: "navigation_back_icon", title: "")
        interactor?.fetchMusicDetail()
    }
    
    func navigateBack() {
        router?.navigateBack()
    }
    
}

extension MediaShareMusicPlayerPresenter: MediaShareMusicPlayerInteractorOutput {
    // TODO: implement interactor output methods
    func fetchedMusicDetail(songName: String, artistName: String, image: Image?) {
        view?.setupMusicDetail(songName: songName, artistName: artistName, image: image)
    }
    
    func playMusic() {
        interactor?.castMusic()
    }
}
