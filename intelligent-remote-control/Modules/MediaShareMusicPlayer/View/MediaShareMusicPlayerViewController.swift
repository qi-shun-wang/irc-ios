//
//  MediaShareMusicPlayerViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareMusicPlayerViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    
    @IBOutlet weak var absoluteTimePosition: UILabel!
    @IBOutlet weak var currentMediaDuration: UILabel!
    @IBOutlet weak var artwork: UIImageView!
    @IBOutlet weak var seekBar: UISlider!
    var presenter: MediaShareMusicPlayerPresentation?
    
    @IBOutlet weak var playBtn: UIButton!
    @IBOutlet weak var previousBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @objc func nextBtnNormalTap(_ sender: UIGestureRecognizer){
        presenter?.pressNext()
    }
    
    @objc func nextBtnLongTap(_ sender: UIGestureRecognizer){
        if sender.state == .ended {
            
        } else if sender.state == .began {
            presenter?.shouldSeekForward()
        }
    }
    
    @objc func previousBtnNormalTap(_ sender: UIGestureRecognizer){
        presenter?.pressPrevious()
    }
    
    @objc func previousBtnLongTap(_ sender: UIGestureRecognizer){
        if sender.state == .ended {
            
        } else if sender.state == .began {
            presenter?.shouldSeekBack()
        }
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                presenter?.cached(at:TimeInterval(slider.value))
            case .moved:
                presenter?.seeking(at:TimeInterval(slider.value))
            case .ended:
                presenter?.seeked(at:TimeInterval(slider.value))
            default:
                break
            }
        }
    }
    
    @IBAction func playbackAction(_ sender: UIButton) {
        presenter?.pressPlayMusic()
    }
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    override func setupNavigationBarStyle() {
        
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {
        let back = UIButton()
        back.setImage(UIImage(named:named)?.withRenderingMode(.alwaysOriginal), for: .normal)
        back.setTitle(text, for: .normal)
        back.setTitleColor(.black, for: .normal)
        back.sizeToFit()
        back.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        let left = UIBarButtonItem(customView: back)
        navigationItem.leftBarButtonItem = left
    }
    
    @objc private func backAction(){
        presenter?.navigateBack()
    }
    
    override func setupNavigationRightItem(image named: String, title text: String) {}
}

extension MediaShareMusicPlayerViewController: MediaShareMusicPlayerView {
    
    // TODO: implement view output methods
    func setupMusicDetail(songName: String, artistName: String, image: Image?) {
        artwork.image = image as? UIImage
        let songLabel = UILabel()
        let artistLabel = UILabel()
        songLabel.font = UIFont.systemFont(ofSize: 20)
        songLabel.text = songName
        songLabel.textAlignment = .center
        
        artistLabel.font = UIFont.systemFont(ofSize: 16)
        artistLabel.text = artistName
        artistLabel.textAlignment = .center
        
        let view = UIStackView(arrangedSubviews: [songLabel,artistLabel])
        view.alignment = .fill
        view.distribution = .fillProportionally
        view.axis = .vertical
        navigationItem.titleView = view
        
    }
    
    func setupPlayImage(named: String) {
        playBtn.setImage(UIImage(named:named), for: .normal)
    }
    
    func setupPlayer(isEnable: Bool) {
        playBtn.isEnabled = isEnable
    }
    
    func setupSeekBar(){
        seekBar.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
    }
    
    func setupNextBUtton(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(nextBtnNormalTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        nextBtn.addGestureRecognizer(tapGesture)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(nextBtnLongTap(_:)))
        nextBtn.addGestureRecognizer(longGesture)
    }
    
    func setupPreviousButton(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(previousBtnNormalTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        previousBtn.addGestureRecognizer(tapGesture)
        
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(previousBtnLongTap(_:)))
        previousBtn.addGestureRecognizer(longGesture)
    }
    
    func setupCurrentMediaDurationLabel(with text:String){
        currentMediaDuration.text = text
    }
    
    func setupAbsoluteTimePositionLabel(with text:String){
        absoluteTimePosition.text = text
    }
    
    func setupSeekBarPosition(with value:Float){
        seekBar.value = value
    }
}
