//
//  MusicPlayerViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import LNPopupController

class MusicPlayerViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    var playbackItem:UIBarButtonItem!
    var playNextItem:UIBarButtonItem!
    @IBOutlet weak var albumArtImageView: UIImageView!
    var songTitle: String = "" {
        didSet {
            if isViewLoaded {
                songNameLabel.text = songTitle
            }
            
            popupItem.title = songTitle
        }
    }
    var albumTitle: String = "" {
        didSet {
            if isViewLoaded {
                albumNameLabel.text = albumTitle
            }
            if ProcessInfo.processInfo.operatingSystemVersion.majorVersion <= 9 {
                popupItem.subtitle = albumTitle
            }
        }
    }
    var albumArt: UIImage = UIImage() {
        didSet {
            if isViewLoaded {
                albumArtImageView.image = albumArt
            }
            popupItem.image = albumArt
            popupItem.accessibilityImageLabel = NSLocalizedString("Album Art", comment: "")
        }
    }
    let accessibilityDateComponentsFormatter = DateComponentsFormatter()
    
    var timer : Timer?
    
    var presenter: MusicPlayerPresentation?

    @IBAction func castAction(_ sender: UIButton) {
        presenter?.performCast()
    }
    // MARK: Lifecycle
    @objc func playbackAction(){
        presenter?.playback()
    }
    
    override func viewDidLoad() {
        presenter?.performInit()
        songNameLabel.text = songTitle
        albumNameLabel.text = albumTitle
        albumArtImageView.image = albumArt
    }
    
}

extension MusicPlayerViewController: MusicPlayerView {
    
    func setupMusicDetail(songName: String, artistName: String, image: Image?) {
        songTitle = songName
        albumTitle = artistName
        albumArt = image as? UIImage ?? UIImage(named:"album_art_default")!
    }
    
    func setupPopupLeftBar(){
        playbackItem = UIBarButtonItem(image: UIImage(named: "pause"), style: .plain, target:self , action: #selector(MusicPlayerViewController.playbackAction))
        playbackItem.accessibilityLabel = NSLocalizedString("Pause", comment: "")
        popupItem.leftBarButtonItems = [ playbackItem ]
    }
    
    func setupPopupRightBar(){
        playNextItem = UIBarButtonItem(image: UIImage(named: "nextFwd"), style: .plain, target: nil, action: nil)
        playNextItem.accessibilityLabel = NSLocalizedString("Next Track", comment: "")
        
        popupItem.rightBarButtonItems = [ playNextItem ]
        
        accessibilityDateComponentsFormatter.unitsStyle = .spellOut
    }
    
    func setupPlaybackImage(named: String) {
        playbackItem.image = UIImage(named:named)
    }
    
    func updateProgress(duration:TimeInterval){
        popupItem.progress += 0.0002;
        popupItem.accessibilityProgressLabel = NSLocalizedString("Playback Progress", comment: "")
        
        popupItem.accessibilityProgressValue = "\(accessibilityDateComponentsFormatter.string(from: TimeInterval(popupItem.progress) * duration)!) \(NSLocalizedString("of", comment: "")) \(accessibilityDateComponentsFormatter.string(from: duration)!)"
        
        progressView.progress = popupItem.progress
        
        if popupItem.progress >= 1.0 {
            presenter?.stopProgress()
            popupPresentationContainer?.dismissPopupBar(animated: true, completion: nil)
        }
    }
}
