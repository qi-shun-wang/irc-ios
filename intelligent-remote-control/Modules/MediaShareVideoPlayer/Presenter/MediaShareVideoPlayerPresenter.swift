//
//  MediaShareVideoPlayerPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import AVFoundation

class MediaShareVideoPlayerPresenter {

    // MARK: Properties

    weak var view: MediaShareVideoPlayerView?
    var router: MediaShareVideoPlayerWireframe?
    var interactor: MediaShareVideoPlayerUseCase?
    
    var player: AVPlayer?
//    var startTime:CMTime?//updated by a ref of trimmerView.startTime
//    var endTime:CMTime?
    
    var playbackTimeCheckerTimer: Timer?
    var trimmerPositionChangedTimer: Timer?
    
    @objc fileprivate func itemDidFinishPlaying() {
        let startTime = view?.fetchTrimmerTime().start
        if let startTime = startTime {
            player?.seek(to: startTime)
            view?.setupPlaybackImage(named: "play")
            
        }
    }
    
    
    func startPlaybackTimeChecker() {
        
        stopPlaybackTimeChecker()
        playbackTimeCheckerTimer = Timer
            .scheduledTimer(timeInterval: 0.1,
                            target: self,
                            selector:#selector(self.onPlaybackTimeChecker),
                            userInfo: nil,
                            repeats: true)
        view?.setupPlaybackImage(named: "pause")
        
        
    }
    
    
    func stopPlaybackTimeChecker() {
        
        view?.setupPlaybackImage(named: "play")
        
        playbackTimeCheckerTimer?.invalidate()
        playbackTimeCheckerTimer = nil
    }
    
    
    @objc func onPlaybackTimeChecker() {
        let timeSet = view?.fetchTrimmerTime()
        guard let startTime = timeSet?.start, let endTime = timeSet?.end, let player = player else {
            return
        }
        
        let playBackTime = player.currentTime()
        view?.setupTrimmerViewSeek(to:playBackTime)
        
        view?.setupPositionBar(timeText: player.currentTime().seconds.parseDuration2())
        
        if playBackTime >= endTime {
            player.seek(to: startTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
            view?.setupTrimmerViewSeek(to:startTime)
            
        }
    }
}

extension MediaShareVideoPlayerPresenter: MediaShareVideoPlayerPresentation {
    func viewDidLoad() {
        interactor?.fetchAsset()
    }
    
    func prepareCasting() {
        router?.presentDMRList()
    }
    
    func setup(_ player: AVPlayer) {
        
        self.player = player
    }
    
    func positionBarStopedMoving(at time: CMTime) {
        player?.seek(to: time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        player?.play()
        startPlaybackTimeChecker()
    }
    func positionBarChanged(at time: CMTime) {
        stopPlaybackTimeChecker()
        player?.pause()
        player?.seek(to: time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
//        let duration = (trimmerView.endTime! - trimmerView.startTime!).seconds
//        print(duration)
    }
}

extension MediaShareVideoPlayerPresenter: MediaShareVideoPlayerInteractorOutput {
    
    func didLoad(_ video:AVAsset){
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(self.itemDidFinishPlaying),
                         name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                         object: nil)
        
        view?.setupThumbSelectorView(with: video)
    }
    
    func playback() {
        guard let player = player else { return }
        
        if !player.isPlaying {
            player.play()
            startPlaybackTimeChecker()
        } else {
            player.pause()
            stopPlaybackTimeChecker()
        }
    }
}
