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
    
    fileprivate var player: AVPlayer!
    
    var isRemoteMode:Bool = false
    var isRemotePlaying:Bool = false
    var isRemoteSeeking:Bool = false
    
    var currentVideo:AVAsset?
    var progressHasFinishedTracking: Bool = true
    var worker:Timer?
    var current:Double = 0 {
        didSet{
            view?.setupPositionBar(timeText: current.parseDuration2())
            view?.updateMediaProgressBar(value: Float(current))
        }
    }
    
    func performSeek(isTracking: Bool, value: Float) {
        
        if isTracking {
            progressHasFinishedTracking = false
            //dragging
            print("dragging:\(value)")
        } else {
            if progressHasFinishedTracking {
                
            } else {
                progressHasFinishedTracking = true
                //end of traking
                if isRemoteMode {
                    isRemoteSeeking = true
                    interactor?.performRemoteSeek(at: Double(value))
                } else {
                    let trackingTime = CMTime(seconds: Double(value), preferredTimescale: CMTimeScale(600))
                    player.seek(to:trackingTime)
                }
                
                print("\(value)")
            }
            
        }
    }
    
    func startWorker() {
        
        worker = Timer
            .scheduledTimer(timeInterval: 0.5,
                            target: self,
                            selector:#selector(onPlaybackTimeChecker),
                            userInfo: nil,
                            repeats: true)
        
    }
    
    func stopWorker() {
        worker?.invalidate()
        worker = nil
    }
    
    @objc func onPlaybackTimeChecker() {
        let duration =  player.currentItem?.asset.duration.seconds ?? 0
        if current >= duration || current >= duration-1 {
            view?.setupPlaybackImage(named: "play")
            isRemotePlaying = false
            player.seek(to: CMTime(seconds: 0, preferredTimescale: CMTimeScale(CMTimeScale.bitWidth)))
            player.pause()
            current = 0
            return
        }
        if isRemoteMode
        {
            if isRemotePlaying && !isRemoteSeeking
            {
                interactor?.fetchRemoteTimeInterval()
            }
            else
            {
                
            }
        }
        else
        {
            if player.isPlaying
            {
                current = player.currentTime().seconds
            }
            else
            {
                
            }
            
        }
    }
}

extension MediaShareVideoPlayerPresenter: MediaShareVideoPlayerPresentation {
    
    func performPlayback() {
        if isRemoteMode
        {
            view?.setupPlaybackAction(isEnable: false)
            if isRemotePlaying
            {
                interactor?.performRemotePause()
            }
            else
            {
                interactor?.performRemotePlay()
            }
        }
        else
        {
            if player.isPlaying
            {
                view?.setupPlaybackImage(named: "play")
                player.pause()
            }
            else
            {
                view?.setupPlaybackImage(named: "pause")
                player.play()
            }
        }
    }
    
    func viewDidLoad() {
        view?.setupMediaProgressBar()
        interactor?.fetchAsset()
    }
    
    func prepareCasting() {
        router?.presentDMRList()
    }
    
    func prepareCurrentDevice() {
        interactor?.fetchCurrentDevice()
    }
}

extension MediaShareVideoPlayerPresenter: MediaShareVideoPlayerInteractorOutput {
    
    func didLoad(_ video:AVAsset){
        currentVideo = video
        
        let playerItem = AVPlayerItem(asset: video)
        player = AVPlayer(playerItem: playerItem)
        view?.setupPlayerLayerView(with: player!)
        view?.setupMediaProgress(maximumValue:  Float(playerItem.asset.duration.seconds))
        view?.updateMediaProgressBar(value: 0)
        startWorker()
    }
    
    func playRemoteDevice(_ device: DMR) {
        view?.showWarningBadge(with: "正在準備推送影片...")
        isRemoteMode = true
        interactor?.setupCurrentRemoteAsset()
    }
    
    func playLocalDevice() {
        interactor?.performRemoteStop()
        isRemoteMode = false
        isRemotePlaying = false
    }
    
    func didSetRemoteAssetSuccess() {
        view?.hideWarningBadge(with: "推送成功!")
        interactor?.performRemotePlay()
    }
    
    func didSetRemoteAssetFailure() {
        
    }
    
    func didPlayRemoteAssetSuccess() {
        view?.setupPlaybackAction(isEnable: true)
        view?.setupPlaybackImage(named: "pause")
        isRemotePlaying = true
    }
    
    func didPlayRemoteAssetFailure() {
        
    }
    
    func didStopRemoteAssetFailure() {
       
    }
    
    func didPauseRemoteAssetSuccess() {
        view?.setupPlaybackAction(isEnable: true)
        view?.setupPlaybackImage(named: "play")
        isRemotePlaying = false
    }
    
    func didPauseRemoteAssetFailure() {
        
    }
    
    func didSeekRemoteAssetSuccess() {
        isRemoteSeeking = false
    }
    
    func didSeekRemoteAssetFailure() {
        
    }
    
    func didFetchRemoteTimeFailure() {
        
    }
    
    func didFetchRemoteTimeSuccess(seconds: TimeInterval) {
        current = seconds
    }
}
