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
    
    var shouldRemotePlayWhenInit:Bool = false
    
    var isPlay:Bool = false
    var isLocalPlay:Bool = true
    
    var timer : Timer?
    
    var progressPosition:Float = 0
    var volumePosition:Float = 0
    var duration:TimeInterval = 0
    var isSeeking:Bool = false {
        didSet{
            print(isSeeking,preparedSeekPosition)
        }
    }
    var preparedSeekPosition:TimeInterval = 0
    
    let playlistSectionIndex = 1
    
    @objc func _timerTicked(_ timer: Timer) {
        if isSeeking {return}
        progressPosition += 1/Float(duration)
        if progressPosition >= 1.0 {
            next()
            return
        }
        view?.updateStartTimeLabel(text: "\(TimeInterval(Double(progressPosition)*duration).parseDuration2())")
        view?.updateEndTimeLabel(text: "-\(TimeInterval(duration*Double(1-progressPosition)).parseDuration2())")
        view?.setupProgress(progress: progressPosition)
    }
    
    func startProgress() {
        stopProgress()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MusicPlayerPresenter._timerTicked(_:)), userInfo: nil, repeats: true)
    }
}

extension MusicPlayerPresenter: MusicPlayerPresentation {
   
    func preparedVolume(at position: Float) {
        volumePosition = position
        if isLocalPlay {
            interactor?.setVolume(position)
        } else {
            interactor?.setRemoteVolume(Int(position*100))
        }
    }
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
        volumePosition = interactor?.volumeInfo() ?? 0
        view?.setupPopupLeftBar()
        view?.setupPopupRightBar()
        view?.setupWarningBadge()
        view?.reloadSections(at: 0)
        view?.setupVolume(position: volumePosition)
        if shouldRemotePlayWhenInit {
            isLocalPlay = false
            interactor?.cast()
        }
    }
    
    func performDeinit() {
        timer?.invalidate()
        interactor?.stop()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        if indexPath.section == playlistSectionIndex {
            stopProgress()
            interactor?.playNewPlaylist(at: indexPath.row)
        }
    }
    
    func playerCellInfo() -> (songName: String, albumName: String, albumArtImage: Image?) {
        let song = interactor!.currentPlaying()
        return (song.name,song.albumName,song.artworkImage)
    }
    
    func next() {
        if isLocalPlay {
            interactor?.next()
        } else {
            interactor?.remoteNextPlay()
        }
    }
    func previous() {
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
    func changeRepeatMode() {
        interactor?.changeRepeatMode()
    }
    
    func didPlayedRemotePrevious() {
        view?.reloadSections(at: playlistSectionIndex)
        view?.reloadSections(at: 0)
        progressPosition = 0
        view?.setupVolume(position: volumePosition)
        view?.setupPlaybackImage(named: isPlay ? "nowPlaying_play":"nowPlaying_pause")
        view?.setupProgress(progress: 0)
    }
    
    func didPlayedRemoteNext() {
        view?.reloadSections(at: playlistSectionIndex)
        view?.reloadSections(at: 0)
        progressPosition = 0
        view?.setupVolume(position: volumePosition)
        view?.setupPlaybackImage(named: isPlay ? "nowPlaying_play":"nowPlaying_pause")
        view?.setupProgress(progress: 0)
    }
    
    func didCasted() {
        //TODO:If casted success , start remote play
        view?.hideWarningBadge(with: "推送成功!")
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
        interactor?.remoteVolumeInfo()
        view?.showWarningBadge(with: "正在準備推送音樂...")
        interactor?.cast()
        //TODO:cast music to remote renderer
    }
    func didRemoteStoped() {
        //TODO:If remote device stoped,get remote position
        //TODO:seek the player position at remote position
        //TODO:play music at local device
        preparedSeek(at: progressPosition)
        
        view?.setupVolume(position: interactor?.volumeInfo() ?? 0)
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
        
        view?.reloadSections(at: playlistSectionIndex)
        view?.reloadSections(at: 0)
        view?.setupPlaybackImage(named: isPlay ? "nowPlaying_play":"nowPlaying_pause")
        progressPosition = 0
        view?.setupVolume(position: volumePosition)
        view?.setupProgress(progress: 0)
        if isLocalPlay {
            interactor?.play()
        }else{
            interactor?.cast()
        }
        
    }
    func didPlayed() {
        view?.setupPopupItemPlaybackImage(named:"pause")
        view?.setupPlaybackImage(named: "nowPlaying_pause")
        startProgress()
    }
    func didPlayedNext() {
        view?.reloadSections(at: 0)
        view?.reloadSections(at: playlistSectionIndex)
        progressPosition = 0
        view?.setupVolume(position: volumePosition)
        view?.setupPlaybackImage(named: isPlay ? "nowPlaying_play":"nowPlaying_pause")
        view?.setupProgress(progress: 0)
        view?.updateStartTimeLabel(text: "00:00")
        view?.updateEndTimeLabel(text: "00:00")
    }
    func didPlayedPrevious() {
        view?.reloadSections(at: 0)
        view?.reloadSections(at: playlistSectionIndex)
        progressPosition = 0
        view?.setupVolume(position: volumePosition)
        view?.setupPlaybackImage(named: isPlay ? "nowPlaying_play":"nowPlaying_pause")
        view?.setupProgress(progress: 0)
        view?.updateStartTimeLabel(text: "00:00")
        view?.updateEndTimeLabel(text: "00:00")
    }
    func didFetchedRemoteVolume(_ value: Int) {
        view?.setupVolume(position: Float(value)/100)
    }
    func currentPlayDetail(duration: TimeInterval) {
        self.duration = duration
        startProgress()
    }
    func didChangeRepeatMode(_ mode: RepeatMode) {
        switch mode {
        case .none:
            view?.setupRepeatModeImage(named: "repeat_color_icon", isSelect: false)
        case .repeat:
            view?.setupRepeatModeImage(named: "repeat_white_icon", isSelect: true)
        case .repeatOnce:
            view?.setupRepeatModeImage(named: "repeat_white1_icon", isSelect: true)
        }
    }
}
