//
//  KaraokeViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit
import WebKit

struct Karaoke {
    let name:String
    let artist:String
    let hasMV:Bool
    let hasGuideVocal:Bool
}

class KaraokeViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var karaokeSearchBar: KaraokeSearchBar!
    @IBOutlet weak var playerControlPanel: PlayerControlPanel!
    @IBOutlet weak var settingControlPanel: SettingControlPanel!
    @IBOutlet weak var bookmarkBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    private var isPlayingListOpened:Bool = true
    private var isPlayedListOpened:Bool = true
    
    @objc func togglePlayingList(_ sender:UIButton) {
        
        if isPlayingListOpened {
            isPlayingListOpened = false
            karaokeArray = []
        } else {
            isPlayingListOpened = true
            karaokeArray = [
                Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: true),
                Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: true),
                Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: false),
                Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: false)
            ]
            
        }
        tableView.reloadData()
    }
    
    lazy var cancelDispatchAction:Callback = {
        
    }
    
    lazy var settingDispatchAction:Callback = {
        self.playerControlPanel.isHidden = false
    }
    lazy var switchDispatchAction:ViewCallback = { view in
        self.playerControlPanel.isHidden = false
        self.settingControlPanel.isHidden = false
        view.isHidden = true
    }
    
    var presenter: KaraokePresentation?
    var shouldShowSearchResults = false
    var playedKaraokeArray:[Karaoke] = [
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: true, hasGuideVocal: true),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: false, hasGuideVocal: true),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: true, hasGuideVocal: false),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: false, hasGuideVocal: false)

    ]
    
    var karaokeArray:[Karaoke] = [
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: true),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: true),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: false),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: false)
    ]
    
    var searchedArray:[Karaoke] = [
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: true, hasGuideVocal: true),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: false, hasGuideVocal: true),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: true, hasGuideVocal: false),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: false, hasGuideVocal: false)
    ]
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControlPanelView()
        
    }
}

extension KaraokeViewController: KaraokeView {
    // TODO: implement view output methods
    
    func setupControlPanelView(){
        karaokeSearchBar.cancelDispatchAction = cancelDispatchAction
        karaokeSearchBar.settingDispatchAction = settingDispatchAction
        settingControlPanel.switchDispatchAction = switchDispatchAction
        playerControlPanel.switchDispatchAction = switchDispatchAction
        let lightBlue = UIColor(red:127/255.0, green:174/255.0, blue:224/255.0, alpha: 1)
        let blue = UIColor(red:0/255.0, green:120/255.0, blue:234/255.0, alpha: 1)
        let deepBlue = UIColor(red:63/255.0, green:96/255.0, blue:210/255.0, alpha: 1)
        let deepPink = UIColor(red:190/255.0, green:38/255.0, blue:135/255.0, alpha: 1)
        let pink = UIColor(red:233/255.0, green:128/255.0, blue:168/255.0, alpha: 1)
        let purple = UIColor(red:145/255.0, green:0/255.0, blue:146/255.0, alpha: 1)
        searchBtn.centerVertically()
        bookmarkBtn.centerVertically()
        searchBtn.applyGradient(colours: [lightBlue,blue,deepBlue,.black], locations: [0.0,0.4,0.9,1.0])
        bookmarkBtn.applyGradient(colours: [pink,deepPink,purple,.black], locations: [0.0,0.4,0.9,1.0])
        
    }
}

extension KaraokeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        let title = UILabel()
        let toggle = UIButton()
        
        if isPlayingListOpened {
            toggle.setImage(UIImage(named:"karaoke_arrow_down_icon"), for: .normal)
        } else {
            toggle.setImage(UIImage(named:"karaoke_minus_icon"), for: .normal)
        }
        
        title.textColor = .white
        title.text = "待唱列表"
        header.backgroundColor = UIColor.black
        header.addSubview(title)
        header.addSubview(toggle)
        toggle.contentHorizontalAlignment = .right
        toggle.addTarget(self, action: #selector(togglePlayingList(_:)), for: .touchUpInside)
        toggle.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.left.equalToSuperview()
        }
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(16)
        }
        return header
    }
    
}

extension KaraokeViewController: UITableViewDataSource {
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return searchedArray.count
        }else {
            return karaokeArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KaraokeCell", for: indexPath) as! KaraokeCell
        let info:Karaoke
        if shouldShowSearchResults {
            info = searchedArray[indexPath.row]
        } else {
            info = karaokeArray[indexPath.row]
        }
        
        let red = UIColor(red:255/255.0, green:0/255.0, blue:30/255.0, alpha: 1)
        let green = UIColor(red:0/255.0, green:228/255.0, blue:132/255.0, alpha: 1)
        
        cell.title.text = info.name
        cell.subtitle.text = info.artist
        if info.hasGuideVocal && info.hasMV {
            cell.sign.isHidden = false
            cell.sign2.isHidden = false
            cell.sign.text = "MV"
            cell.sign2.text = "導"
            cell.sign.backgroundColor = red
            cell.sign2.backgroundColor = green
        } else {
            cell.sign.isHidden = true
            cell.sign2.isHidden = false
            cell.sign2.text = info.hasGuideVocal ? "MV":"導"
            cell.sign2.backgroundColor = info.hasGuideVocal ? red : green
        }
        return cell
    }
}
