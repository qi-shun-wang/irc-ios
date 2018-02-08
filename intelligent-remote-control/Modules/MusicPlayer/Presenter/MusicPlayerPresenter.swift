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
    
    var isPlay:Bool = false
    var isLocalPlay:Bool = true
    var isRemotePlay:Bool = false
    
    var timer : Timer?
    var isLocalPlayer:Bool = true
    
    var duration:TimeInterval = 0
    
    @objc func _timerTicked(_ timer: Timer) {
        view?.updateProgress(duration:duration)
    }
  
    func startProgress() {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(MusicPlayerPresenter._timerTicked(_:)), userInfo: nil, repeats: true)
    }
}

extension MusicPlayerPresenter: MusicPlayerPresentation {
 
    func performInit() {
        view?.setupPopupLeftBar()
        view?.setupPopupRightBar()
    }
    
    func playback() {
        isPlay = !isPlay
        if isPlay {
            interactor?.pause()
        }else {
            interactor?.play()
        }
    }
    
    func performCast() {
        router?.presentDMRList()
    }
    
    func stopProgress() {
        timer?.invalidate()
    }
    
    func prepareCurrentDevice() {
        interactor?.fetchCurrentDevice()
    }
}

extension MusicPlayerPresenter: MusicPlayerInteractorOutput {
    func playRemoteDevice(_ device: DMR) {
        //TODO:check local device whether is playing
        //TODO:Pause current music
        //TODO:get current paused position of the music
        //TODO:cast music to remote renderer
        //TODO:Seek the posistion into remote renderer
        //TODO:Play the remote renderer
    }
    
    func playLocalDevice() {
        //TODO:check remote device whether is casting
        //TODO:Stop remote device
        //TODO:seek the player position at remote position
        //TODO:play music at local device
    }
    
    func update(song: Song) {
        view?.setupMusicDetail(songName:song.name, artistName:song.artistName, image: song.artworkImage)
    }
    
    func didPaused() {
        view?.setupPlaybackImage(named: "play")
        stopProgress()
    }
    
    func didPlayed() {
        view?.setupPlaybackImage(named: "pause")
        startProgress()
    }
    
    func currentPlayDetail(duration: TimeInterval) {
        self.duration = duration
        startProgress()
    }
    
}
