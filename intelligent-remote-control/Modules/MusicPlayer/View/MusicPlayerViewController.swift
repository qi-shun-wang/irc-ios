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
    
    @IBOutlet weak var tableView: UITableView!
    var playbackItem:UIBarButtonItem!
    var playNextItem:UIBarButtonItem!
    weak var progressRef:UISlider!
    weak var playbackRef:UIButton!
    weak var repeatModeRef:UIButton!
    weak var volumeRef:UISlider!
    weak var startTimeRef:UILabel?
    weak var endTimeRef:UILabel?
    
    let accessibilityDateComponentsFormatter = DateComponentsFormatter()
    
    var presenter: MusicPlayerPresentation?
    
    @objc func castAction() {
        presenter?.performCast()
    }
    @objc func playbackAction(){
        presenter?.playback()
    }
    @objc func backwardAction(){
        presenter?.previous()
    }
    @objc func forwardAction(){
        presenter?.next()
    }
    // MARK: Lifecycle
    override func viewDidLoad() {
        presenter?.performInit()
    }
    
}


extension MusicPlayerViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return view.frame.height - view.statusBarHeight()
        } else {
            return 70
        }
    }
}


extension MusicPlayerViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell") as! PlayerCell
            let info = presenter?.playerCellInfo()
            cell.songNameLabel.text = info?.songName
            cell.albumNameLabel.text = info?.albumName
            cell.albumArtImageView.image = info?.albumArtImage as? UIImage
            cell.playbackBtn.addTarget(self, action: #selector(MusicPlayerViewController.playbackAction), for:.touchUpInside)
            cell.backwardBtn.addTarget(self, action: #selector(MusicPlayerViewController.backwardAction), for:.touchUpInside)
            cell.forwardBtn.addTarget(self, action: #selector(MusicPlayerViewController.forwardAction), for:.touchUpInside)
            cell.castBtn.addTarget(self, action: #selector(MusicPlayerViewController.castAction), for:.touchUpInside)
            playbackRef = cell.playbackBtn
            progressRef = cell.slidableProgressBar
            volumeRef = cell.volumeSlider
            startTimeRef = cell.startTime
            endTimeRef = cell.endTime
            
            cell.dragging = {
                self.popupPresentationContainer?.popupContentView.popupInteractionGestureRecognizer.isEnabled = false
                tableView.isScrollEnabled = false
                self.presenter?.seeking()
                print("dragging")
            }
            cell.finished = { value in
                self.popupPresentationContainer?.popupContentView.popupInteractionGestureRecognizer.isEnabled = true
                tableView.isScrollEnabled = true
                self.presenter?.preparedSeek(at: value)
                print("finished")
            }
            
            cell.volumeDragging = {
                self.popupPresentationContainer?.popupContentView.popupInteractionGestureRecognizer.isEnabled = false
                tableView.isScrollEnabled = false
            }
            cell.volumeFinished = { value in
                self.popupPresentationContainer?.popupContentView.popupInteractionGestureRecognizer.isEnabled = true
                tableView.isScrollEnabled = true
                self.presenter?.preparedVolume(at: value)
            }
            return cell
//        } else if indexPath.section == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerModeCell") as! PlayerModeCell
//            repeatModeRef = cell.repeatBtn
//            cell.changeRepeatMode = {
//                self.presenter?.changeRepeatMode()
//            }
//            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NextMusicCell")!
            let info = presenter?.getNewPlaylistItemInfo(at: indexPath.row)
            cell.textLabel?.text = info?.songName
            cell.detailTextLabel?.text = info?.albumName
            cell.imageView?.image = info?.albumArtImage as? UIImage ?? UIImage(named:"album_art_default")
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return presenter!.getNewPlaylistAmount()
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2//3
    }
    
}


extension MusicPlayerViewController: MusicPlayerView {
    
    func reloadSections(at index:Int){
        tableView.reloadSections(IndexSet(integer: index), with: .automatic)
    }
    
    func setupMusicDetail(songName: String, artistName: String, image: Image?) {
        popupItem.title = songName
        popupItem.subtitle = artistName
        popupItem.image = image as? UIImage ?? UIImage(named:"album_art_default")!
        popupItem.accessibilityImageLabel = NSLocalizedString("Album Art", comment: "")
    }
    
    func setupPopupLeftBar(){
        playbackItem = UIBarButtonItem(image: UIImage(named: "pause"), style: .plain, target:self , action: #selector(MusicPlayerViewController.playbackAction))
        playbackItem.accessibilityLabel = NSLocalizedString("Pause", comment: "")
        popupItem.leftBarButtonItems = [ playbackItem ]
    }
    
    func setupPopupRightBar(){
        playNextItem = UIBarButtonItem(image: UIImage(named: "nextFwd"), style: .plain, target: self, action: #selector(MusicPlayerViewController.forwardAction))
        playNextItem.accessibilityLabel = NSLocalizedString("Next Track", comment: "")
        popupItem.rightBarButtonItems = [ playNextItem ]
        accessibilityDateComponentsFormatter.unitsStyle = .spellOut
    }
    
    func setupPopupItemPlaybackImage(named: String){
        playbackItem.image = UIImage(named:named)
    }
    
    func setupPlaybackImage(named: String) {
        if let ref = playbackRef {
            ref.setImage(UIImage(named:named), for: .normal)
        }
    }
    
    func setupRepeatModeImage(named: String,isSelect:Bool) {
        if let ref = repeatModeRef {
            ref.setImage(UIImage(named:named), for: .normal)
            ref.setTitleColor(isSelect ? UIColor.white:UIColor.red, for: .normal)
            ref.backgroundColor = isSelect ? UIColor.red:UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        }
    }
    
    func setupProgress(progress:Float) {
        guard let progressView = progressRef else {return}
        popupItem.progress = progress
        progressView.setValue(progress, animated: true)
    }
    
    func setupVolume(position: Float) {
        guard let volume = volumeRef else {return}
        volume.value = position
    }
    
    func dismissPopupBar(){
        popupPresentationContainer?.dismissPopupBar(animated: true, completion: nil)
    }
    
    func updateStartTimeLabel(text: String) {
        startTimeRef?.text = text
    }
    
    func updateEndTimeLabel(text: String) {
        endTimeRef?.text = text
    }
}
