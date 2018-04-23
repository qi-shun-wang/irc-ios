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

class KaraokeViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var karaokeSearchBar: KaraokeSearchBar!
    @IBOutlet weak var playerControlPanel: PlayerControlPanel!
    @IBOutlet weak var settingControlPanel: SettingControlPanel!
    @IBOutlet weak var bookmarkBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    
    @IBAction func navigateToBookmarkAction(_ sender: UIButton) {
        presenter?.navigateToBookmark()
    }
    
    @IBAction func navigateToFinderAction(_ sender: UIButton) {
        presenter?.navigateToFinder()
    }
    
    @objc func togglePlayingList(_ sender:UIButton) {
        presenter?.togglePlayingList()
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
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
}

extension KaraokeViewController: KaraokeView {
    
    func setupControlPanelView(){
        karaokeSearchBar.cancelDispatchAction = cancelDispatchAction
        karaokeSearchBar.settingDispatchAction = settingDispatchAction
        karaokeSearchBar.delegate = self
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
    
    func setupTableViewTag(){
        tableView.tag = 0
        searchTableView.tag = 1
    }
    
    func reloadTableView(){
        tableView.reloadData()
    }
    
    func reloadSearchTableView(){
        searchTableView.reloadData()
    }
}

extension KaraokeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionInfo = presenter!.viewForHeader(in:section,with:tableView.tag)else {return nil}
        let header = UIView()
        let title = UILabel()
        let toggle = UIButton()
        toggle.setImage(UIImage(named:sectionInfo.iconName), for: .normal)
        title.textColor = .white
        title.text = sectionInfo.title
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(integerLiteral: presenter!.heightForHeader(in:section,with:tableView.tag))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(in:section,with:tableView.tag)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KaraokeCell", for: indexPath) as! KaraokeCell
        let info =  presenter!.cellForRow(at: indexPath, with: tableView.tag)
        cell.title.text = info.name
        cell.subtitle.text = info.artist
        cell.sign.isHidden = info.signHidden
        cell.sign2.isHidden = info.sign2Hidden
        cell.sign.text = info.signText
        cell.sign2.text = info.signText2
        if #available(iOS 11.0, *) {
            cell.sign.backgroundColor = UIColor(named: info.signColor)
            cell.sign2.backgroundColor = UIColor(named: info.signColor2)
        } else {
            // Fallback on earlier versions
            cell.sign.backgroundColor = UIColor.red
            cell.sign2.backgroundColor = UIColor.green
        }
        
        
        return cell
    }
}

extension KaraokeViewController: KaraokeSearchBarDelegate {
    
    func didTapOnSearchField() {
        searchTableView.isHidden = false
        presenter?.startSearchMode()
    }
    
    func didCancelOnSearchField() {
        searchTableView.isHidden = true
        presenter?.stopSearchMode()
    }
    
    func didChangeSearchText(_ text: String) {
        presenter?.inputSearchText(text)
    }
    
    
}
