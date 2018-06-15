//
//  MusicPlayerContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol MusicPlayerView: BaseView {
    func setupRepeatModeImage(named: String,isSelect:Bool)
    func setupMusicDetail(songName:String,artistName:String,image:Image?)
    func setupPopupLeftBar()
    func setupPopupRightBar()
    func setupPopupItemPlaybackImage(named: String)
    func setupPlaybackImage(named:String)
    func setupProgress(progress:Float)
    func reloadSections(at index:Int)
    func setupVolume(position:Float)
    func updateStartTimeLabel(text:String)
    func updateEndTimeLabel(text:String)
}

protocol MusicPlayerPresentation: class {
    
    func changeRepeatMode()
    func didSelectRow(at indexPath:IndexPath)
    func performInit()
    func performDeinit()
    func playback()
    func previous()
    func next()
    func seeking()
    func preparedSeek(at position:Float)
    func preparedVolume(at position:Float)
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
    func changeRepeatMode()
    func volumeInfo() -> Float
    func remoteVolumeInfo()
    func seek(at time:TimeInterval)
    func stop()
    func play()
    func playNewPlaylist(at index:Int)
    func next()
    func previous()
    func pause()
    func setVolume(_ value: Float)
    
    func fetchCurrentDevice()
    func currentPlaying() -> Song
    func getNewPlaylistAmount() -> Int
    func getNewPlaylistItem(at index:Int) -> Song
    
    func cast()
    func remotePlay()
    func remoteSeek(at time:TimeInterval)
    func remoteStop()
    func remotePause()
    func remoteNextPlay()
    func remotePreviousPlay()
    func setRemoteVolume(_ value:Int)
}

protocol MusicPlayerInteractorOutput: class {
    func didChangeRepeatMode(_ mode:RepeatMode)
    func update(song:Song)
    func currentPlayDetail(duration:TimeInterval)
    func didPlayedNext()
    func didPlayedPrevious()
    func didChangedNewPlaylist()
    func didPlayed()
    func didPaused()
    func playRemoteDevice(_ device:DMR)
    func playLocalDevice()
    func didCasted()
    func didRemotePlayed()
    func didRemoteSeeked()
    func didRemoteStoped()
    func didRemotePaused()
    func didPlayedRemoteNext()
    func didPlayedRemotePrevious()
    func didFetchedRemoteVolume(_ value:Int)
}

protocol MusicPlayerWireframe: class {
    func presentDMRList()
}
