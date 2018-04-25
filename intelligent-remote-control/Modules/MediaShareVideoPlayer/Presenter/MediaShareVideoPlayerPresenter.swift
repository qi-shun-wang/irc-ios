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
    
    fileprivate var player: AVPlayer?//Ref setup from View
    //    var startTime:CMTime?//updated by a ref of trimmerView.startTime
    //    var endTime:CMTime?
    var isRemotePlaying:Bool = false
    var isLocalPlay:Bool = true
    var playbackTimeCheckerTimer: Timer?
    var trimmerPositionChangedTimer: Timer?
    var currentVideo:AVAsset?
    
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
    
    func positionBarStopedMoving(at time: CMTime) {
        if isLocalPlay {
            player?.seek(to: time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
            player?.play()
        }else{
            interactor?.remoteSeek(at: time.seconds)
        }
        startPlaybackTimeChecker()
    }
    func positionBarChanged(at time: CMTime) {
        stopPlaybackTimeChecker()
        if isLocalPlay {
            player?.pause()
            player?.seek(to: time, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
        }else{
            interactor?.remoteSeek(at: time.seconds)
        }
        //        let duration = (trimmerView.endTime! - trimmerView.startTime!).seconds
        //        print(duration)
    }
    
    func prepareCurrentDevice() {
        interactor?.fetchCurrentDevice()
    }
}

extension MediaShareVideoPlayerPresenter: MediaShareVideoPlayerInteractorOutput {
    func failureCasted(with error: Error) {
        
    }
    
    func playRemoteDevice(_ device: DMR) {
        view?.showWarningBadge(with: "正在準備推送影片...")
        isLocalPlay = false
        //TODO: cast src to dmr for remote play
        interactor?.cast()
        
        
    }
    func playLocalDevice() {
        interactor?.remoteStop()
        isLocalPlay = true
        //TODO : change to local play
    }
    
    func didCasted() {
        view?.hideWarningBadge(with: "推送成功!")
        interactor?.remotePlay()
    }
    func didRemotePlayed() {
        view?.setupPlaybackImage(named: "pause")
        startPlaybackTimeChecker()
        isRemotePlaying = true
    }
    
    func didRemoteSeeked() {
        interactor?.remotePlay()
    }
    
    func didRemoteStoped() {
        isRemotePlaying = false
    }
    
    func didRemotePaused() {
        view?.setupPlaybackImage(named: "play")
        stopPlaybackTimeChecker()
        isRemotePlaying = false
    }
    
    
    func didLoad(_ video:AVAsset){
        currentVideo = video
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(self.itemDidFinishPlaying),
                         name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                         object: nil)
        
        let playerItem = AVPlayerItem(asset: video)
        player = AVPlayer(playerItem: playerItem)
        view?.setupThumbSelectorView(with: player!)
    }
    
    func playback() {
        guard let player = player else { return }
        if isLocalPlay{
            
            if !player.isPlaying {
                
                player.play()
                startPlaybackTimeChecker()
            } else {
                player.pause()
                stopPlaybackTimeChecker()
            }
        } else {
            
            if isRemotePlaying {
                interactor?.remotePause()
            }else{
                interactor?.remotePlay()
            }
        }
    }
    
}
