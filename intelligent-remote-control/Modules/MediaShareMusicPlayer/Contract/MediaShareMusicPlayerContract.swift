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
    func setupSeekBarPosition(with value:Float)
    func setupCurrentMediaDurationLabel(with text:String)
    func setupAbsoluteTimePositionLabel(with text:String)
    func setupPreviousButton()
    func setupNextBUtton()
    func setupPlayModeIcon(with name:String)
}

protocol MediaShareMusicPlayerPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func pressPlayMusic()
    func pressPrevious()
    func pressNext()
    func shouldSeekBack()
    func shouldSeekForward()
    func changePlayMode()
    func navigateBack()
    func seeked(at absPosition:TimeInterval)
    func seeking(at absPosition:TimeInterval)
    func cached(at absPosition:TimeInterval)
}

protocol MediaShareMusicPlayerUseCase: class {
    // TODO: Declare use case methods
    func fetchMusicDetail()
    func castMusic()
    func playMusic()
    func pauseMusic()
    func changePlayMode()
    func seekMusic(at position:String)
    func playPreviousMusic()
    func playNextMusic()
}

protocol MediaShareMusicPlayerInteractorOutput: class {
    // TODO: Declare interactor output methods
    func fetchedMusicDetail(songName:String,artistName:String,image:Image?,duration:TimeInterval)
    func updated(absoluteTimePosition :String)
    func castedMusic()
    func playedMusic()
    func pausedMusic()
    func seekedMusic(absoluteTimePosition: String)
    func stopedMusic()
    func changedRepeatOrderMode()
    func changedRepeatOnceMode()
    func changedNormalMode()
    func failureCastedMusic()
    func failurePlayedMusic()
    func failurePausedMusic()
    func failureSeekedMusic()
    func failureSetPlayMode()
    
}

protocol MediaShareMusicPlayerWireframe: class {
    // TODO: Declare wireframe methods
    func navigateBack()
}
