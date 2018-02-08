//
//  MusicPlayerContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MusicPlayerView: BaseView {
    func setupMusicDetail(songName:String,artistName:String,image:Image?)
    func setupPopupLeftBar()
    func setupPopupRightBar()
    func setupPlaybackImage(named:String)
    func updateProgress(duration:TimeInterval)
}

protocol MusicPlayerPresentation: class {
    func performInit()
    func playback()
    func performCast()
    func stopProgress()
    func prepareCurrentDevice()
}

protocol MusicPlayerUseCase: class {
    func cast()
    func play()
    func pause()
    func fetchCurrentDevice()
}

protocol MusicPlayerInteractorOutput: class {
    func update(song:Song)
    func currentPlayDetail(duration:TimeInterval)
    func didPlayed()
    func didPaused()
    func playRemoteDevice(_ device:DMR)
    func playLocalDevice()
}

protocol MusicPlayerWireframe: class {
    func presentDMRList()
}
