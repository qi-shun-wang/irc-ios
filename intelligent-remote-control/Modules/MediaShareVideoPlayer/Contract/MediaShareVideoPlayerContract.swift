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
    func setupThumbSelectorView(with asset:AVAsset)
    func setupTrimmerViewSeek(to:CMTime)
    func setupPositionBar(timeText:String)
    func setupPlaybackImage(named: String)
    func fetchTrimmerTime() -> (start:CMTime?,end:CMTime?)
}

protocol MediaShareVideoPlayerPresentation: class {
    func viewDidLoad()
    func prepareCasting()
    func playback()
    func setup(_ player:AVPlayer)
    func positionBarStopedMoving(at time:CMTime)
    func positionBarChanged(at time:CMTime)
//    func update(duration time:CMTime)
}

protocol MediaShareVideoPlayerUseCase: class {
    // TODO: Declare use case methods
    func fetchAsset()
}

protocol MediaShareVideoPlayerInteractorOutput: class {
    func didLoad(_ video:AVAsset)
}

protocol MediaShareVideoPlayerWireframe: class {
    func presentDMRList()
}
