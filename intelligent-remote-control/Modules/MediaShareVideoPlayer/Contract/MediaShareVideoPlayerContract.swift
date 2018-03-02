//
//  MediaShareVideoPlayerContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import AVFoundation

protocol MediaShareVideoPlayerView: BaseView {
    func setupThumbSelectorView(with player:AVPlayer)
    func setupTrimmerViewSeek(to:CMTime)
    func setupPositionBar(timeText:String)
    func setupPlaybackImage(named: String)
    func fetchTrimmerTime() -> (start:CMTime?,end:CMTime?)
}

protocol MediaShareVideoPlayerPresentation: class {
    func viewDidLoad()
    func prepareCasting()
    func playback()
    func positionBarStopedMoving(at time:CMTime)
    func positionBarChanged(at time:CMTime)
//    func update(duration time:CMTime)
    func prepareCurrentDevice()
}

protocol MediaShareVideoPlayerUseCase: class {
    // TODO: Declare use case methods
    func fetchAsset()
    func cast()
    func remotePlay()
    func remoteSeek(at time:TimeInterval)
    func remoteStop()
    func remotePause()
    func fetchCurrentDevice()
}

protocol MediaShareVideoPlayerInteractorOutput: class {
    
    func playRemoteDevice(_ device:DMR)
    func playLocalDevice()
    func didLoad(_ video:AVAsset)
    func failureCasted(with error:Error)
    
    func didCasted()
    func didRemotePlayed()
    func didRemoteSeeked()
    func didRemoteStoped()
    func didRemotePaused()
}

protocol MediaShareVideoPlayerWireframe: class {
    func presentDMRList()
}
