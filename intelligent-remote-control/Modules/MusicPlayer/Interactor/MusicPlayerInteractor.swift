//
//  MusicPlayerInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import AVFoundation

class MusicPlayerInteractor {
    
    // MARK: Properties
    
    weak var output: MusicPlayerInteractorOutput? {
        didSet {
            output?.update(song: playlist[currentPlayIndex])
            output?.currentPlayDetail(duration: player.currentItem!.asset.duration.seconds)
            //TODO:Can not play Music App 's item
        }
    }
    
    let dlnaManager:DLNAMediaManagerProtocol
    var playlist:[Song]
    
    var currentPlayIndex:Int
    var preparedSeekTime:TimeInterval = 0
    var repeatMode:RepeatMode = .none {
        didSet {
            output?.didChangeRepeatMode(repeatMode)
        }
    }
    
    weak var player:AVPlayer!
    
    func setupPlayer(_ player:AVPlayer){
        self.player = player
        prepared(playlist[currentPlayIndex],by: player)
        play()
    }
    
    init(dlnaManager:DLNAMediaManagerProtocol,with playlist: [Song],at index:Int) {
        self.playlist = playlist
        self.currentPlayIndex = index
        self.dlnaManager = dlnaManager //as! DLNAMediaManager
        (self.dlnaManager as! DLNAMediaManager).delegate = self
    }
    
    fileprivate func prepared(_ song:Song,by player:AVPlayer){
        guard let url = song.songURL else {
            print("song URL is nil")
            return
        }
        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)
    }
    
    fileprivate func indexIncrement(){
        if currentPlayIndex < playlist.count - 1
        {
            currentPlayIndex += 1
        }
        else
        {
            currentPlayIndex = 0
        }
    }
    
    fileprivate func indexDecrement(){
        if currentPlayIndex > 0
        {
            currentPlayIndex -= 1
        }
        else
        {
            currentPlayIndex = playlist.count - 1
        }
    }
}

extension MusicPlayerInteractor: MusicPlayerUseCase {
    
    func changeRepeatMode() {
        repeatMode = repeatMode.next()
    }
    
    func volumeInfo() -> Float {
        return player.volume
    }
    
    func remoteVolumeInfo() {
        dlnaManager.fetchVolume { (value, error) in
            self.output?.didFetchedRemoteVolume(value)
        }
    }
    
    func stop() {
        player.pause()
    }
    
    func seek(at time: TimeInterval) {
        let cmTime = CMTime(seconds: time, preferredTimescale: CMTimeScale(600))
        player.seek(to: cmTime)
    }
    
    func playNewPlaylist(at index:Int){
        let song = playlist[index]
        guard let i = playlist.index(where: {$0.songURL == song.songURL}) else {return}
        currentPlayIndex = i
        prepared(playlist[currentPlayIndex],by: player)
        
        output?.update(song: playlist[currentPlayIndex])
        output?.didChangedNewPlaylist()
    }
    
    func next() {
        indexIncrement()
        
        player.pause()
        prepared(playlist[currentPlayIndex],by: player)
        player.play()
        output?.update(song: playlist[currentPlayIndex])
        output?.didPlayedNext()
    }
    
    func previous() {
        indexDecrement()
        
        player.pause()
        prepared(playlist[currentPlayIndex],by: player)
        player.play()
        output?.update(song: playlist[currentPlayIndex])
        output?.didPlayedPrevious()
    }
    
    func getNewPlaylistAmount() -> Int {
        return playlist.count
    }
    
    func getNewPlaylistItem(at index: Int) -> Song {
        return playlist[index]
    }
    
    func currentPlaying() -> Song {
        return playlist[currentPlayIndex]
    }
    
    func fetchCurrentDevice() {
        
        guard let device = dlnaManager.getCurrentDevice() else {
            output?.playLocalDevice()
            return
        }
        output?.playRemoteDevice(device)
        
    }
    
    func cast() {
        pause()
        dlnaManager.stop { (isSuccess, error) in
            casting()
        }
        
        func casting(){
            guard let assetURL = playlist[currentPlayIndex].songURL else {return}
            dlnaManager.castSong(for: assetURL) { (isSuccess, error) in
                guard isSuccess else {return}
                self.output?.didCasted()
            }
        }
    }
    
    func remotePlay(){
        dlnaManager.play { (isSuccess, error) in
            if isSuccess {self.output?.didRemotePlayed()}
        }
    }
    
    func remotePause() {
        dlnaManager.pause{ (isSuccess, error) in
            if isSuccess {self.output?.didRemotePaused()}
        }
    }
    
    func remoteSeek(at time:TimeInterval){
        dlnaManager.seek(at: time.parseDuration()) { (isSuccess, error)  in
            if isSuccess {self.output?.didRemoteSeeked()}
        }
    }
    
    func remoteStop() {
        dlnaManager.stop { (isSuccess, error) in
            if isSuccess {self.output?.didRemoteStoped()}
        }
    }
    
    func remoteNextPlay() {
        indexIncrement()
        player.pause()
        prepared(playlist[currentPlayIndex],by: player)
        cast()
        output?.update(song: playlist[currentPlayIndex])
        output?.didPlayedRemoteNext()
    }
    
    func remotePreviousPlay() {
        indexDecrement()
        player.pause()
        prepared(playlist[currentPlayIndex],by: player)
        cast()
        
        output?.update(song: playlist[currentPlayIndex])
        output?.didPlayedRemotePrevious()
    }
    
    func setRemoteVolume(_ value: Int) {
        dlnaManager.change(volume: value)
    }
    
    func setVolume(_ value: Float) {
        player.volume = value
        //TODO:set up local volume
    }
    
    func play() {
        player.play()
        output?.didPlayed()
    }
    
    func pause() {
        player.pause()
        if let total = player.currentItem?.asset.duration.seconds {
            preparedSeekTime = total -  player.currentTime().seconds
        }
        output?.didPaused()
    }
    
}
extension MusicPlayerInteractor: DLNAMediaManagerDelegate {
    func didEventRecieved(_ event: Dictionary<AnyHashable, Any>) {
        
    }
    
    func didFailureChangeVolume() {
        
    }
    
    func didFailureChangeMute() {
        
    }
    
    func didFind(device: DMR) {
        
    }
    
    func didRemove(at index: Int) {
        
    }
    
    func didChangeMute() {
        
    }
    
    func didChangeVolume() {
        
    }
    
    func didSetupTransportService() {
        
    }
    
    func didSetupRenderService() {
        
    }
    
    
}
