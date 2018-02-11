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
    func setupPopupItemPlaybackImage(named: String)
    func setupPlaybackImage(named:String)
    func updateProgress(duration:TimeInterval)
    func setupProgress(progress:Float)
    func reloadSections(at index:Int)
}

protocol MusicPlayerPresentation: class {
    func didSelectRow(at indexPath:IndexPath)
    func performInit()
    func performDeinit()
    func playback()
    func previous()
    func next()
    func seeking()
    func preparedSeek(at position:Float)
    func forward()
    func backward()
    func performCast()
    func stopProgress()
    func prepareCurrentDevice()
    func playerCellInfo() -> (songName:String, albumName:String, albumArtImage:Image?)
    func getNewPlaylistAmount() -> Int
    func getNewPlaylistItemInfo(at index:Int)->(songName:String, albumName:String, albumArtImage:Image?)
    
}

protocol MusicPlayerUseCase: class {
    func cast()
    func seek(at time:TimeInterval)
    func stop()
    func play()
    func playNewPlaylist(at index:Int)
    func next()
    func previous()
    func pause()
    func fetchCurrentDevice()
    func currentPlaying() -> Song
    func getNewPlaylistAmount() -> Int
    func getNewPlaylistItem(at index:Int) -> Song
}

protocol MusicPlayerInteractorOutput: class {
    func update(song:Song)
    func currentPlayDetail(duration:TimeInterval)
    func didPlayedNext()
    func didPlayedPrevious()
    func didChangedNewPlaylist()
    func didPlayed()
    func didPaused()
    func playRemoteDevice(_ device:DMR)
    func playLocalDevice()
}

protocol MusicPlayerWireframe: class {
    func presentDMRList()
}
