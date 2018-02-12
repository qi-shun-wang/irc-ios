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
    var timer:Timer?
    
    var isPlaying:Bool = false {
        didSet {
            if isPlaying {
                startTimer()
            } else {
                killTimer()
            }
        }
    }
    var currentMediaDuration:TimeInterval = 0
    var cachedLastAbsPosition:TimeInterval = 0 {
        didSet{
            let text = cachedLastAbsPosition.parseDuration2()
            view?.setupAbsoluteTimePositionLabel(with: text)
            view?.setupSeekBarPosition(with: Float(cachedLastAbsPosition/currentMediaDuration))
        }
    }
    
    final func killTimer(){
        self.timer?.invalidate()
        self.timer = nil
    }
    
    
    final private func startTimer() {
        
        // make it re-entrant:
        // if timer is running, kill it and start from scratch
        self.killTimer()
        let fire = Date().addingTimeInterval(1)
        let deltaT : TimeInterval = 1.0
        
        timer = Timer(fire: fire, interval: deltaT, repeats: true, block: { (t: Timer) in
            if self.cachedLastAbsPosition < self.currentMediaDuration {
                self.cachedLastAbsPosition += 1
            }
            print("cachedLastAbsPosition:\( self.cachedLastAbsPosition)")
            
        })
        
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        
    }
}

extension MediaShareMusicPlayerPresenter: MediaShareMusicPlayerPresentation {
    
    // TODO: implement presentation methods
    func changePlayMode() {
        interactor?.changePlayMode()
    }
    
    func seeked(at absPosition: TimeInterval) {
        let p = absPosition*currentMediaDuration
        let text = p.parseDuration()
        interactor?.seekMusic(at: text)
    }
    
    func seeking(at absPosition: TimeInterval) {
        let p = absPosition*currentMediaDuration
        let text = p.parseDuration2()
        view?.setupAbsoluteTimePositionLabel(with: text)
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
        view?.setupNextBUtton()
        view?.setupPreviousButton()
        view?.setupAbsoluteTimePositionLabel(with: "0:00")
        view?.setupPlayModeIcon(with: "media_share_playmode_normal")
        interactor?.fetchMusicDetail()
        interactor?.castMusic()
        
    }
    
    func navigateBack() {
        router?.navigateBack()
    }
    
    func shouldSeekForward() {
        (cachedLastAbsPosition < currentMediaDuration - 10) ? (cachedLastAbsPosition += 10) : (cachedLastAbsPosition =  currentMediaDuration)
        interactor?.seekMusic(at: cachedLastAbsPosition.parseDuration())
    }
    
    func shouldSeekBack() {
        cachedLastAbsPosition > 10 ? (cachedLastAbsPosition-=10) : (cachedLastAbsPosition = 0)
        interactor?.seekMusic(at: cachedLastAbsPosition.parseDuration())
    }
    
    func pressPrevious() {
        interactor?.playPreviousMusic()
    }
    
    func pressNext() {
        interactor?.playNextMusic()
    }
    
    func cached(at absPosition: TimeInterval) {
        cachedLastAbsPosition = absPosition
    }
    
}

extension MediaShareMusicPlayerPresenter: MediaShareMusicPlayerInteractorOutput {

    func failureSetPlayMode() {
        
    }
    
    func changedRepeatOrderMode() {
        view?.setupPlayModeIcon(with: "media_share_playmode_repeat_order")
    }
    
    func changedRepeatOnceMode() {
        view?.setupPlayModeIcon(with: "media_share_playmode_repeat_once")
    }
    
    func changedNormalMode() {
        view?.setupPlayModeIcon(with: "media_share_playmode_normal")
    }
    // TODO: implement interactor output methods
    func updated(absoluteTimePosition: String) {
        cachedLastAbsPosition = absoluteTimePosition.parseDuration()
    }
    
    func fetchedMusicDetail(songName: String, artistName: String, image: Image?, duration: TimeInterval) {
        view?.setupMusicDetail(songName: songName, artistName: artistName, image: image)
        currentMediaDuration = duration
        
        let text = duration.parseDuration2()
        view?.setupCurrentMediaDurationLabel(with: text)
    }
    
    func castedMusic() {
        
    }
    
    func failureSeekedMusic() {
        let text = cachedLastAbsPosition.parseDuration2()
        view?.setupAbsoluteTimePositionLabel(with: text)
    }
    
    func failureCastedMusic() {
        isPlaying = false
    }
    
    func failurePlayedMusic() {
        isPlaying = false
        view?.setupPlayImage(named: "media_share_music_play")
    }
    
    func failurePausedMusic() {
        isPlaying = true
        view?.setupPlayImage(named: "media_share_music_pause")
    }
    
    func playedMusic() {
        isPlaying = true
        view?.setupPlayImage(named: "media_share_music_pause")
    }
    
    func pausedMusic() {
        isPlaying = false
        view?.setupPlayImage(named: "media_share_music_play")
    }
    
    func seekedMusic(absoluteTimePosition: String) {
        cachedLastAbsPosition = absoluteTimePosition.parseDuration()
    }
    
    func stopedMusic() {
        isPlaying = false
    } 
}
