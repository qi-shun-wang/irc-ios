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

    // MARK: Lifecycle
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let pause = UIBarButtonItem(image: UIImage(named: "pause"), style: .plain, target: nil, action: nil)
        pause.accessibilityLabel = NSLocalizedString("Pause", comment: "")
        let next = UIBarButtonItem(image: UIImage(named: "nextFwd"), style: .plain, target: nil, action: nil)
        next.accessibilityLabel = NSLocalizedString("Next Track", comment: "")
        
        self.popupItem.leftBarButtonItems = [ pause ]
        self.popupItem.rightBarButtonItems = [ next ]
        
        accessibilityDateComponentsFormatter.unitsStyle = .spellOut
        
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(MusicPlayerViewController._timerTicked(_:)), userInfo: nil, repeats: true)
    }
    
    override func viewDidLoad() {
        
        songNameLabel.text = songTitle
        albumNameLabel.text = albumTitle
        albumArtImageView.image = albumArt
    }
    
    @objc func _timerTicked(_ timer: Timer) {
        popupItem.progress += 0.0002;
        popupItem.accessibilityProgressLabel = NSLocalizedString("Playback Progress", comment: "")
        
        let totalTime = TimeInterval(250)
        popupItem.accessibilityProgressValue = "\(accessibilityDateComponentsFormatter.string(from: TimeInterval(popupItem.progress) * totalTime)!) \(NSLocalizedString("of", comment: "")) \(accessibilityDateComponentsFormatter.string(from: totalTime)!)"
        
        progressView.progress = popupItem.progress
        
        if popupItem.progress >= 1.0 {
            timer.invalidate()
            popupPresentationContainer?.dismissPopupBar(animated: true, completion: nil)
        }
    }
}

extension MusicPlayerViewController: MusicPlayerView {
    func setupMusicDetail(songName: String, artistName: String, image: Image?) {
        songTitle = songName
        albumTitle = artistName
        albumArt = image as? UIImage ?? UIImage(named:"album_art_default")!
        
    }
}
