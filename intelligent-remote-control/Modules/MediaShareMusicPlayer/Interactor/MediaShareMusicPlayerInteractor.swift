//
//  MediaShareMusicPlayerInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareMusicPlayerInteractor {
    
    // MARK: Properties
    
    weak var output: MediaShareMusicPlayerInteractorOutput?
    let dlnaManager:DLNAMediaManager
    let song:Song
    
    init(dlnaManager:DLNAMediaManagerProtocol,song: Song) {
        self.song = song
        self.dlnaManager = dlnaManager as! DLNAMediaManager
        self.dlnaManager.delegate = self
    }
    
}

extension MediaShareMusicPlayerInteractor: MediaShareMusicPlayerUseCase {
    
    // TODO: Implement use case methods
    func castMusic() {
        guard let assetURL = song.songURL else {return}
        dlnaManager.castSong(for: assetURL) { (isSuccess, error) in
            guard isSuccess else {self.output?.failureCastedMusic();return}
            self.output?.castedMusic()
        }
        
    }
    
    func playMusic() {
        dlnaManager.playSong { (isSuccess, error) in
            
            guard isSuccess else {self.output?.failurePlayedMusic();return}
            self.output?.playedMusic()
        }
    }
    
    func pauseMusic() {
        dlnaManager.pauseSong { (isSuccess, error) in
            guard isSuccess else {self.output?.failurePausedMusic();return}
            self.output?.pausedMusic()
        }
    }
    
    func fetchMusicDetail(){
        output?.fetchedMusicDetail(songName: song.name, artistName: song.artistName, image: song.artworkImage, duration: song.duration ?? 0)
    }
    
    func playForwardMusic() {
        dlnaManager.playForward { (isSuccess, error) in
            guard isSuccess else {self.output?.failurePlayedMusic();return}
        }
    }
    
    func playBackMusic() {
        dlnaManager.playBack { (isSuccess, error) in
            guard isSuccess else {self.output?.failurePlayedMusic();return}
        }
    }
    
    func seekMusic(at position: String = "00:00:00") {
        dlnaManager.seekSong(at: "00:\(position)") { (isSuccess, error) in
            guard isSuccess else {self.output?.failureSeekedMusic();return}
        }
    }
}


extension MediaShareMusicPlayerInteractor:DLNAMediaManagerDelegate{
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
        print(currentMediaDuration)
    }
    
    func update(absoluteTimePosition: String) {
        let formated = absoluteTimePosition.count == 8 ? absoluteTimePosition.dropFirst(3).lowercased() : "00:00"
        
        output?.updated(absoluteTimePosition:formated)
        print(formated)
    }
    
    func update(transportState: String) {
        print("----->",transportState)
    }
    
    
}

enum TransportState:String {
    
    case paused = "PAUSED_PLAYBACK"
    case playing = "PLAYING"
    case stopped = "STOPPED"
    
}
