//
//  MediaShareMusicPlayerContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MediaShareMusicPlayerView: BaseView {
    // TODO: Declare view methods
    func setupMusicDetail(songName:String,artistName:String,image:Image?)
}

protocol MediaShareMusicPlayerPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func playMusic()
    func navigateBack()
}

protocol MediaShareMusicPlayerUseCase: class {
    // TODO: Declare use case methods
    func fetchMusicDetail()
    func castMusic()
}

protocol MediaShareMusicPlayerInteractorOutput: class {
    // TODO: Declare interactor output methods
    func fetchedMusicDetail(songName:String,artistName:String,image:Image?)
}

protocol MediaShareMusicPlayerWireframe: class {
    // TODO: Declare wireframe methods
    func navigateBack()
}
