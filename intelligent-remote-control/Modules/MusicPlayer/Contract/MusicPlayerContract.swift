//
//  MusicPlayerContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MusicPlayerView: BaseView {
    func setupMusicDetail(songName:String,artistName:String,image:Image?)
}

protocol MusicPlayerPresentation: class {
    // TODO: Declare presentation methods
}

protocol MusicPlayerUseCase: class {
    // TODO: Declare use case methods
}

protocol MusicPlayerInteractorOutput: class {
    // TODO: Declare interactor output methods
    func update(song:Song)
}

protocol MusicPlayerWireframe: class {
    // TODO: Declare wireframe methods
}
