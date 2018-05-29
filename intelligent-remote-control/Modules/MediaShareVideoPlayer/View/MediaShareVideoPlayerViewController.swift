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
    
    @IBOutlet weak var mediaProgress: UISlider!
    @IBOutlet weak var playback: UIButton!
    
    var presenter: MediaShareVideoPlayerPresentation?
   
    @IBAction func playbackAction(_ sender: UIButton) {
        presenter?.performPlayback()
    }
    
    @IBAction func castAction(_ sender: UIButton) {
        presenter?.prepareCasting()
    }
    
    @IBAction func dragAction(_ sender: UISlider) {
        presenter?.performSeek(isTracking: sender.isTracking, value: sender.value)
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {}
    
    override func setupNavigationRightItem(image named: String, title text: String) {}
    
    
}

extension MediaShareVideoPlayerViewController: MediaShareVideoPlayerView {
    
    func setupPlaybackAction(isEnable: Bool) {
        playback.isEnabled = isEnable
    }
    
    func updateMediaProgressBar(value: Float) {
        mediaProgress.value = value
    }
    
    func setupMediaProgress(maximumValue: Float) {
        mediaProgress.maximumValue = maximumValue
    }
    
    func setupMediaProgressBar() {
        mediaProgress.setThumbImage(UIImage(named:"slider_thumb_normal_icon"), for: .normal)
        mediaProgress.setThumbImage(UIImage(named:"slider_thumb_highlighted_icon"), for: .highlighted)
        mediaProgress.setMinimumTrackImage(UIColor.red.convertImage(), for: .highlighted)
    }
    
    func setupPlayerLayerView(with player:AVPlayer){
        guard player.currentItem != nil else {
            print("playItem not set")
            return
        }
      
        let layer: AVPlayerLayer = AVPlayerLayer(player: player)
        layer.backgroundColor = UIColor.white.cgColor
        layer.frame = CGRect(x: 0, y: 0, width: playerView.frame.width, height: playerView.frame.height)
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //        playerView.layer.sublayers?.forEach({$0.removeFromSuperlayer()})
        playerView.layer.addSublayer(layer)
      
    }
    
    func setupPositionBar(timeText:String){
        tipTime.text =  timeText
    }
    
    func setupPlaybackImage(named: String) {
        playback.setImage(UIImage(named:named),for: .normal)
    }
}

