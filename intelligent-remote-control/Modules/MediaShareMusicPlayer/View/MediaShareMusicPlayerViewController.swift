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
    
    @IBOutlet weak var artwork: UIImageView!
    var presenter: MediaShareMusicPlayerPresentation?
    
    @IBAction func playbackAction(_ sender: UIButton) {
        presenter?.playMusic()
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
    
    
    
}
