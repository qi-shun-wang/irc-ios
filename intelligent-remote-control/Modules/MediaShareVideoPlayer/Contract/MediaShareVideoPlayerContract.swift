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
    
    func setupPositionBar(timeText:String)
    func setupPlaybackImage(named: String)
    func setupPlayerLayerView(with player:AVPlayer)
    
    func setupMediaProgressBar()
    func setupMediaProgress(maximumValue:Float)
    func updateMediaProgressBar(value:Float)
    
    func setupPlaybackAction(isEnable:Bool)
}

protocol MediaShareVideoPlayerPresentation: class {
    func viewDidLoad()
    func performSeek(isTracking:Bool,value:Float)
    func prepareCasting()
    func performPlayback() 
    func prepareCurrentDevice()
}

protocol MediaShareVideoPlayerUseCase: class {
    // TODO: Declare use case methods
    func fetchAsset()
    func fetchCurrentDevice()
    func setupCurrentRemoteAsset()
    func performRemotePlay()
    func performRemoteStop()
    func performRemotePause()
    func performRemoteSeek(at time:TimeInterval)
    func fetchRemoteTimeInterval()
}

protocol MediaShareVideoPlayerInteractorOutput: class {
    
    func playRemoteDevice(_ device:DMR)
    func playLocalDevice()
    func didLoad(_ video:AVAsset)
    
    func didSetRemoteAssetSuccess()
    func didSetRemoteAssetFailure()
    
    func didPlayRemoteAssetSuccess()
    func didPlayRemoteAssetFailure()
    
    func didStopRemoteAssetFailure()
    
    func didPauseRemoteAssetSuccess()
    func didPauseRemoteAssetFailure()
    
    func didSeekRemoteAssetSuccess()
    func didSeekRemoteAssetFailure()
    
    func didFetchRemoteTimeSuccess(seconds:TimeInterval)
    func didFetchRemoteTimeFailure()
    
}

protocol MediaShareVideoPlayerWireframe: class {
    func presentDMRList()
}
