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
    func setupPlayImage(named:String)
    func setupPlayer(isEnable:Bool)
    func setupSeekBar()
    func setupCurrentMediaDurationLabel(with text:String)
    func setupAbsoluteTimePositionLabel(with text:String)
}

protocol MediaShareMusicPlayerPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func pressPlayMusic()
    func pressPlayBack()
    func pressPlayForward()
    func navigateBack()
    
    func seeked(at absPosition:Float)
    func seeking(at absPosition:Float)
    func cached(at absPosition:Float)
}

protocol MediaShareMusicPlayerUseCase: class {
    // TODO: Declare use case methods
    func fetchMusicDetail()
    func castMusic()
    func playMusic()
    func pauseMusic()
    func seekMusic(at position:String)
    func playBackMusic()
    func playForwardMusic()
}

protocol MediaShareMusicPlayerInteractorOutput: class {
    // TODO: Declare interactor output methods
    func fetchedMusicDetail(songName:String,artistName:String,image:Image?,duration:Float)
    func updated(absoluteTimePosition :String)
    func castedMusic()
    func playedMusic()
    func pausedMusic()

    func failureCastedMusic()
    func failurePlayedMusic()
    func failurePausedMusic()
    func failureSeekedMusic()
    
}

protocol MediaShareMusicPlayerWireframe: class {
    // TODO: Declare wireframe methods
    func navigateBack()
}
