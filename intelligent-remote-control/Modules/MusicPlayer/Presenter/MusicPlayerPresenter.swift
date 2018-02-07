//
//  MusicPlayerPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MusicPlayerPresenter {

    // MARK: Properties

    weak var view: MusicPlayerView?
    var router: MusicPlayerWireframe?
    var interactor: MusicPlayerUseCase?
}

extension MusicPlayerPresenter: MusicPlayerPresentation {
    // TODO: implement presentation methods
}

extension MusicPlayerPresenter: MusicPlayerInteractorOutput {
    func update(song: Song) {
        view?.setupMusicDetail(songName:song.name, artistName:song.artistName, image: song.artworkImage)
    }
}
