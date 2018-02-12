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
    
    let dlnaManager:DLNAMediaManager
    var playlist:[Song]
    var newPlaylist:[Song] = []
    var currentPlayIndex:Int
    var preparedSeekTime:TimeInterval = 0
    
    weak var player:AVPlayer!
    
    func setupPlayer(_ player:AVPlayer){
        
        self.player = player
        prepared(playlist[currentPlayIndex],by: player)
        updateNewPlaylist(with: currentPlayIndex)
        play()
    }
    init(dlnaManager:DLNAMediaManagerProtocol,with playlist: [Song],at index:Int) {
        self.playlist = playlist
        self.currentPlayIndex = index
        self.dlnaManager = dlnaManager as! DLNAMediaManager
        self.dlnaManager.delegate = self
    }
    
    fileprivate func prepared(_ song:Song,by player:AVPlayer){
        guard let url = song.songURL else {
            print("song URL is nil")
            return
        }
        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)
    }
    
    fileprivate func updateNewPlaylist(with currentPlayIndex:Int){
        let lastIndex:Int = index(before: currentPlayIndex,about:playlist)
        let nextIndex:Int = index(after: currentPlayIndex,about:playlist)
        
        let before = Array(playlist[0...lastIndex])
        newPlaylist = Array(playlist[nextIndex...playlist.count - 1])
        newPlaylist.append(contentsOf: before)
    }
    func index(before currentPlayIndex:Int,about playlist:Array<Any>)->Int {
        let lastIndex:Int
        if currentPlayIndex > 0 {
            lastIndex = currentPlayIndex - 1
        }else {
            lastIndex = playlist.count - 1
        }
        return lastIndex
    }
    func index(after currentPlayIndex:Int,about playlist:Array<Any>)->Int {
        let nextIndex:Int
        if currentPlayIndex < playlist.count - 1 {
            nextIndex = currentPlayIndex + 1
        } else {
            nextIndex = 0
        }
        return nextIndex
    }
    
}

extension MusicPlayerInteractor: MusicPlayerUseCase {
    func stop() {
        player.pause()
    }
    func seek(at time: TimeInterval) {
        let cmTime = CMTime(seconds: time, preferredTimescale: CMTimeScale(600))
        player.seek(to: cmTime)
    }
    func playNewPlaylist(at index:Int){
        let song = newPlaylist[index]
        guard let i = playlist.index(where: {$0.songURL == song.songURL}) else {return}
        currentPlayIndex = i
        player.pause()
        prepared(playlist[currentPlayIndex],by: player)
        player.play()
        updateNewPlaylist(with: currentPlayIndex)
        output?.update(song: playlist[currentPlayIndex])
        output?.didChangedNewPlaylist()
    }
    func next() {
        currentPlayIndex = index(after: currentPlayIndex, about: playlist)
        player.pause()
        prepared(playlist[currentPlayIndex],by: player)
        player.play()
        updateNewPlaylist(with: currentPlayIndex)
        output?.update(song: playlist[currentPlayIndex])
        output?.didPlayedNext()
    }
    
    func previous() {
        currentPlayIndex = index(before: currentPlayIndex, about: playlist)
        player.pause()
        prepared(playlist[currentPlayIndex],by: player)
        player.play()
        updateNewPlaylist(with: currentPlayIndex)
        output?.update(song: playlist[currentPlayIndex])
        output?.didPlayedPrevious()
    }
    
    func getNewPlaylistAmount() -> Int {
        return newPlaylist.count
    }
    
    func getNewPlaylistItem(at index: Int) -> Song {
        return newPlaylist[index]
    }
    
    func currentPlaying() -> Song {
        return playlist[currentPlayIndex]
    }
    
    func fetchCurrentDevice() {
        
        guard let device = dlnaManager.currentDevice else {
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
        dlnaManager.playSong { (isSuccess, error) in
             if isSuccess {self.output?.didRemotePlayed()}
        }
    }
    func remotePause() {
        dlnaManager.pauseSong { (isSuccess, error) in
            if isSuccess {self.output?.didRemotePaused()}
        }
    }
    func remoteSeek(at time:TimeInterval){
        dlnaManager.seekSong(at: time.parseDuration()) { (isSuccess, error)  in
            if isSuccess {self.output?.didRemoteSeeked()}
        }
    }
    func remoteStop() {
        dlnaManager.stop { (isSuccess, error) in
            if isSuccess {self.output?.didRemoteStoped()}
        }
    }
    func remoteNextPlay() {
        currentPlayIndex = index(after: currentPlayIndex, about: playlist)
        player.pause()
        prepared(playlist[currentPlayIndex],by: player)
        cast()
        updateNewPlaylist(with: currentPlayIndex)
        output?.update(song: playlist[currentPlayIndex])
        output?.didPlayedRemoteNext()
    }
    func remotePreviousPlay() {
        currentPlayIndex = index(before: currentPlayIndex, about: playlist)
        player.pause()
        prepared(playlist[currentPlayIndex],by: player)
        cast()
        updateNewPlaylist(with: currentPlayIndex)
        output?.update(song: playlist[currentPlayIndex])
        output?.didPlayedRemotePrevious()
    }
    
    func setRemoteVolume(_ value: Int) {
        dlnaManager.change(volume: value)
    }
    func setVolume(_ value: Int) {
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
    
    func update(currentMediaDuration: String) {
        
    }
    
    func update(absoluteTimePosition: String) {
        let formated = absoluteTimePosition.count == 8 ? absoluteTimePosition.dropFirst(3).lowercased() : "00:00"
        
        
        print(formated)
    }
    
    func update(transportState: String) {
        print(transportState)
    }
    
    func shouldUpdateCurrentMediaDuration() {
        
    }
    
    
}
