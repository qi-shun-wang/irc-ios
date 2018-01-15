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
    var isPlaying:Bool = false
    var currentMediaDuration:Float = 0
    var cachedLastAbsPosition:Float = 0
}

extension MediaShareMusicPlayerPresenter: MediaShareMusicPlayerPresentation {
    
    // TODO: implement presentation methods
    func seeked(at absPosition: Float) {
         let text = "\(Int(absPosition*currentMediaDuration/60)):\(Int(absPosition*currentMediaDuration)%60)"
        interactor?.seekMusic(at: text)
    }
    func seeking(at absPosition: Float) {
        let text = "\(Int(absPosition*currentMediaDuration/60)):\(Int(absPosition*currentMediaDuration)%60)"
        view?.setupAbsoluteTimePositionLabel(with: text)
    }
    func pressPlayBack() {
        interactor?.playBackMusic()
    }
    
    func pressPlayForward() {
        interactor?.playForwardMusic()
    }
    
    func pressPlayMusic() {
        if isPlaying {
            interactor?.pauseMusic()
        }else {
            interactor?.playMusic()
        }
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupNavigationLeftItem(image: "navigation_back_icon", title: "")
        view?.setupPlayImage(named: "media_share_music_play")
        view?.setupSeekBar()
        view?.setupAbsoluteTimePositionLabel(with: "0:00")
        interactor?.fetchMusicDetail()
        interactor?.castMusic()
    }
    
    func navigateBack() {
        router?.navigateBack()
    }
    
    func pressSeekForward() {
        
    }
    
    func pressSeekBack() {
        
    }
    
    func cached(at absPosition: Float) {
        cachedLastAbsPosition = absPosition
    }
    
}

extension MediaShareMusicPlayerPresenter: MediaShareMusicPlayerInteractorOutput {
    func updated(absoluteTimePosition: String) {
        view?.setupAbsoluteTimePositionLabel(with: absoluteTimePosition)
    }
    
    func fetchedMusicDetail(songName: String, artistName: String, image: Image?, duration: Float) {
        view?.setupMusicDetail(songName: songName, artistName: artistName, image: image)
        currentMediaDuration = duration
        let text = "\(Int(duration/60)):\(Int(duration)%60)"
        view?.setupCurrentMediaDurationLabel(with: text)
        
    }
    
    func castedMusic() {
        
    }
    
    func failureSeekedMusic() {
        let text = "\(Int(cachedLastAbsPosition/60)):\(Int(cachedLastAbsPosition)%60)"
        view?.setupAbsoluteTimePositionLabel(with: text)
    }
    func failureCastedMusic() {
        
    }
    
    func failurePlayedMusic() {
        view?.setupPlayImage(named: "media_share_music_play")
        
    }
    
    func failurePausedMusic() {
        view?.setupPlayImage(named: "media_share_music_pause")
    }
    
    // TODO: implement interactor output methods
    func playedMusic() {
        isPlaying = true
        view?.setupPlayImage(named: "media_share_music_pause")
    }
    
    func pausedMusic() {
        isPlaying = false
        view?.setupPlayImage(named: "media_share_music_play")
        
    }
    
    func stopedMusic() {
        
    } 
}
