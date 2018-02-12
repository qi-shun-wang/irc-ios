//
//  MusicPlayerPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MusicPlayerPresenter {
    
    // MARK: Properties
    
    weak var view: MusicPlayerView?
    var router: MusicPlayerWireframe?
    var interactor: MusicPlayerUseCase?
    
    var isPlay:Bool = false
    var isLocalPlay:Bool = true
    var isRemotePlay:Bool = false
    
    var timer : Timer?
    var isLocalPlayer:Bool = true
    var progressPosition:Float = 0
    var duration:TimeInterval = 0
    var isSeeking:Bool = false {
        didSet{
            print(isSeeking,preparedSeekPosition)
        }
    }
    var preparedSeekPosition:TimeInterval = 0
    @objc func _timerTicked(_ timer: Timer) {
        if isSeeking {return}
        progressPosition += 1/Float(duration)
        if progressPosition >= 1.0 {
            next()
            return
        }
        view?.setupProgress(progress: progressPosition)
    }
    
    func startProgress() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MusicPlayerPresenter._timerTicked(_:)), userInfo: nil, repeats: true)
    }
}

extension MusicPlayerPresenter: MusicPlayerPresentation {
    
    func preparedSeek(at position: Float) {
        progressPosition = position
        isSeeking = false
        if isLocalPlay {
            interactor?.seek(at: Double(position)*duration)
        }else {
            interactor?.remoteSeek(at: Double(position)*duration)
        }
        view?.setupProgress(progress: position)
    }
    
    func seeking() {
        isSeeking = true
    }
    
    func performInit() {
        view?.setupPopupLeftBar()
        view?.setupPopupRightBar()
        view?.reloadSections(at: 0)
    }
    func performDeinit() {
        timer?.invalidate()
        interactor?.stop()
    }
    func didSelectRow(at indexPath: IndexPath) {
        if indexPath.section == 2 {
            interactor?.playNewPlaylist(at: indexPath.row)
        }
    }
    func playerCellInfo() -> (songName:String, albumName:String, albumArtImage:Image?) {
        let song = interactor!.currentPlaying()
        return (song.name,song.albumName,song.artworkImage)
    }
    func next() {
        progressPosition = 0
        view?.setupProgress(progress: 0)
        if isLocalPlay {
            interactor?.next()
        }else {
            interactor?.remoteNextPlay()
        }
        
    }
    func previous() {
        progressPosition = 0
        view?.setupProgress(progress: 0)
        if isLocalPlay {
            interactor?.previous()
        } else {
            interactor?.remotePreviousPlay()
        }
        
    }
    func backward() {
        
    }
    func forward() {
        
    }
    func playback() {
        isPlay = !isPlay
        if isLocalPlay {
            if isPlay {
                interactor?.pause()
            } else {
                interactor?.play()
            }
        } else {
            if isPlay {
                interactor?.remotePause()
            } else {
                interactor?.remotePlay()
            }
        }
    }
    
    func performCast() {
        router?.presentDMRList()
    }
    
    func stopProgress() {
        timer?.invalidate()
    }
    
    func prepareCurrentDevice() {
        interactor?.fetchCurrentDevice()
    }
    
    func getNewPlaylistAmount() -> Int {
        return interactor!.getNewPlaylistAmount()
    }
    
    func getNewPlaylistItemInfo(at index: Int) -> (songName: String, albumName: String, albumArtImage: Image?) {
        let song = interactor!.getNewPlaylistItem(at: index)
        return (song.name,song.albumName,song.artworkImage)
    }
}

extension MusicPlayerPresenter: MusicPlayerInteractorOutput {
    func didPlayedRemotePrevious() {
        view?.reloadSections(at: 0)
        view?.reloadSections(at: 2)
    }
    
    func didPlayedRemoteNext() {
        view?.reloadSections(at: 0)
        view?.reloadSections(at: 2)
    }
    func didCasted() {
        //TODO:If casted success , start remote play
        interactor?.remotePlay()
    }
    
    func didRemotePlayed() {
        //TODO:If played success , seek to current timeinterval
        interactor?.remoteSeek(at: Double(progressPosition)*duration)
        startProgress()
    }
    
    func didRemoteSeeked() {
        //TODO:If remote seek success , start local progress
        view?.setupPopupItemPlaybackImage(named:"pause")
        view?.setupPlaybackImage(named: "nowPlaying_pause")
    }
    
    func didRemotePaused() {
        view?.setupPopupItemPlaybackImage(named:  "play")
        view?.setupPlaybackImage(named: "nowPlaying_play")
        stopProgress()
    }
   
    func playRemoteDevice(_ device: DMR) {
        stopProgress()
        //TODO:check local device whether is playing
        //TODO:Pause current music
        isLocalPlay = false
        
        interactor?.cast()
        //TODO:cast music to remote renderer
    }
    func didRemoteStoped() {
        //TODO:If remote device stoped,get remote position
        //TODO:seek the player position at remote position
        //TODO:play music at local device
        preparedSeek(at: progressPosition)
        interactor?.play()
    }
    func playLocalDevice() {
        stopProgress()
        isLocalPlay = true
        //TODO:Stop remote device
        interactor?.remoteStop()
    }
    
    func update(song: Song) {
        view?.setupMusicDetail(songName:song.name, artistName:song.artistName, image: song.artworkImage)
    }
    
    func didPaused() {
        view?.setupPopupItemPlaybackImage(named:  "play")
        view?.setupPlaybackImage(named: "nowPlaying_play")
        stopProgress()
    }
    func didChangedNewPlaylist() {
        view?.setupPopupItemPlaybackImage(named:"pause")
        view?.setupPlaybackImage(named: "nowPlaying_pause")
        view?.reloadSections(at: 0)
        view?.reloadSections(at: 2)
        startProgress()
    }
    func didPlayed() {
        view?.setupPopupItemPlaybackImage(named:"pause")
        view?.setupPlaybackImage(named: "nowPlaying_pause")
        startProgress()
    }
    func didPlayedNext() {
        view?.reloadSections(at: 0)
        view?.reloadSections(at: 2)
    }
    func didPlayedPrevious() {
        view?.reloadSections(at: 0)
        view?.reloadSections(at: 2)
    }
    func currentPlayDetail(duration: TimeInterval) {
        self.duration = duration
        startProgress()
    }
    
}
