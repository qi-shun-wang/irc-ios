//
//  MediaShareVideoPlayerViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MediaShareVideoPlayerViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    @IBOutlet weak var tipTime: UILabel!
    @IBOutlet weak var playerView: UIView!
    
    @IBOutlet weak var playback: UIButton!
    @IBOutlet weak var trimmerView: TrimmerView!
    var presenter: MediaShareVideoPlayerPresentation?
    var player: AVPlayer?
    var playbackTimeCheckerTimer: Timer?
    var trimmerPositionChangedTimer: Timer?
    
    @IBAction func playbackAction(_ sender: UIButton) {
//
//        guard let player = player else { return }
//
//        if !player.isPlaying {
//            player.play()
//            startPlaybackTimeChecker()
//        } else {
//            player.pause()
//            stopPlaybackTimeChecker()
//        }
        presenter?.playback()
    }
    @IBAction func castAction(_ sender: UIButton) {
        presenter?.prepareCasting()
    }
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {}
    
    override func setupNavigationRightItem(image named: String, title text: String) {}
    
    
//
//    @objc fileprivate func itemDidFinishPlaying() {
//        if let startTime = trimmerView.startTime {
//            player?.seek(to: startTime)
//            setupPlaybackImage(named: "play")
//
//        }
//    }
    
//    func startPlaybackTimeChecker() {
//
//        stopPlaybackTimeChecker()
//        playbackTimeCheckerTimer = Timer
//            .scheduledTimer(timeInterval: 0.1,
//                            target: self,
//                            selector:#selector(MediaShareVideoPlayerViewController.onPlaybackTimeChecker),
//                            userInfo: nil,
//                            repeats: true)
//        setupPlaybackImage(named: "pause")
//
//
//    }
    
//    func stopPlaybackTimeChecker() {
//
//        setupPlaybackImage(named: "play")
//
//        playbackTimeCheckerTimer?.invalidate()
//        playbackTimeCheckerTimer = nil
//    }
    
//    @objc func onPlaybackTimeChecker() {
//
//        guard let startTime = trimmerView.startTime, let endTime = trimmerView.endTime, let player = player else {
//            return
//        }
//
//        let playBackTime = player.currentTime()
//        setupTrimmerViewSeek(to:playBackTime)
//
//        setupPositionBar(timeText: player.currentTime().seconds.parseDuration2())
//
//        if playBackTime >= endTime {
//            player.seek(to: startTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
//            setupTrimmerViewSeek(to:startTime)
//
//        }
//    }
}

extension MediaShareVideoPlayerViewController: MediaShareVideoPlayerView {
    
    func fetchTrimmerTime() -> (start:CMTime?,end:CMTime?){
        return (trimmerView.startTime,trimmerView.endTime)
    }
    
    func setupTrimmerViewSeek(to time:CMTime){
        trimmerView.seek(to: time)
    }
    
    func setupPositionBar(timeText:String){
        tipTime.text =  timeText
    }
    func setupPlaybackImage(named: String) {
        playback.setImage(UIImage(named:named),for: .normal)
    }
    
    func setupThumbSelectorView(with asset:AVAsset){
        trimmerView.delegate = self
        trimmerView.asset = asset
        
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        presenter?.setup(player)
        
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: playerView.frame.width, height: playerView.frame.height)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //        playerView.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        playerView.layer.addSublayer(layer)
       setupPositionBar(timeText: playerItem.duration.seconds.parseDuration2())
    }
}

extension MediaShareVideoPlayerViewController: TrimmerViewDelegate {
    func positionBarStoppedMoving(_ playerTime: CMTime) {
        presenter?.positionBarStopedMoving(at: playerTime)
       
    }
    
    func didChangePositionBar(_ playerTime: CMTime) {
        presenter?.positionBarChanged(at: playerTime)
        
    }
}
