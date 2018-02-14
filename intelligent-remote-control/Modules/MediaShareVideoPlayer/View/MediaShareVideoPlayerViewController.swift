//
//  MediaShareVideoPlayerViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit
import PryntTrimmerView
import AVFoundation

class MediaShareVideoPlayerViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    @IBOutlet weak var tipTime: UILabel!
    @IBOutlet weak var videoCropView: VideoCropView!
    @IBOutlet weak var thumbView: ThumbSelectorView!
    var presenter: MediaShareVideoPlayerPresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        videoCropView.setAspectRatio(CGSize(width: 1, height:1), animated: false)
        presenter?.viewDidLoad()
    }
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {}
    
    override func setupNavigationRightItem(image named: String, title text: String) {}
    
}

extension MediaShareVideoPlayerViewController: MediaShareVideoPlayerView {
    // TODO: implement view output methods
    func setupThumbSelectorView(with asset:AVAsset){
        thumbView.asset = asset
        thumbView.delegate = self
        videoCropView.asset = asset  
    }
}
extension MediaShareVideoPlayerViewController:ThumbSelectorViewDelegate {
    func didChangeThumbPosition(_ imageTime: CMTime) {
        tipTime.text = imageTime.seconds.parseDuration2()
        videoCropView.player?.seek(to: imageTime, toleranceBefore: kCMTimeZero, toleranceAfter: kCMTimeZero)
    }
    
}
