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
            output?.update(song: song)
            output?.currentPlayDetail(duration: player.currentItem!.asset.duration.seconds)
        }
    }
    
    let dlnaManager:DLNAMediaManager
    let song:Song
    let player:AVPlayer
    
    init(dlnaManager:DLNAMediaManagerProtocol,song: Song) {
        self.song = song
        self.dlnaManager = dlnaManager as! DLNAMediaManager
        player = AVPlayer()
        prepared(song,by: player)
        play()
        //        self.dlnaManager.delegate = self
    }
    
    private func prepared(_ song:Song,by player:AVPlayer){
        guard let url = song.songURL else {
            print("song URL is nil")
            return
        }
        let item = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: item)
    }
}

extension MusicPlayerInteractor: MusicPlayerUseCase {
    
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
            if isSuccess {casting()}
        }
        
        func casting(){
            guard let assetURL = song.songURL else {return}
            dlnaManager.castSong(for: assetURL) { (isSuccess, error) in
                //            guard isSuccess else {self.output?.failureCastedMusic();return}
                //            self.output?.castedMusic()
            }
        }
    }
    
    func play() {
        player.play()
        output?.didPlayed()
    }
    
    func pause() {
        player.pause()
        output?.didPaused()
    }
    
}
