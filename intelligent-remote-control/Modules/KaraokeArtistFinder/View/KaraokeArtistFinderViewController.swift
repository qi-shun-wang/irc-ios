//
//  KaraokeArtistFinderViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class KaraokeArtistFinderViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var karaokeTypeControlPanel: KaraokeTypeControlPanel!
    @IBOutlet weak var karaokeZoneControlPanel: TabbedSlider!
    var sliderItems:[Tab] = [
        Tab(title: "台灣"),
        Tab(title: "香港"),
        Tab(title: "大陸"),
        Tab(title: "日韓/新馬"),
        Tab(title: "歐美"),
    ]
    var presenter: KaraokeArtistFinderPresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20),
            NSAttributedStringKey.foregroundColor: UIColor.white
        ]
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {
        let left = UIBarButtonItem(image: UIImage(named:named)?.withRenderingMode(.alwaysOriginal),
                                   style: .plain,
                                   target: self,
                                   action: #selector(backAction)
        )
        
        navigationItem.leftBarButtonItem = left
    }
    
    override func setupNavigationRightItem(image named: String, title text: String) {
        
    }
    
    @objc private func backAction(){
        presenter?.navigateBack()
    }
}

extension KaraokeArtistFinderViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(at: indexPath,with:tableView.tag)
    }
}

extension KaraokeArtistFinderViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistCell
        let cellInfo = presenter!.cellForRow(at: indexPath)
        cell.title.text = cellInfo.title
        cell.subtitle.text = cellInfo.subtitle
        return cell
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(in: section)
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}

extension KaraokeArtistFinderViewController: TabbedSliderDelegate {
    
    func didChange(positionOf tab: Int) {
        presenter?.changeZone(tab + 1)
    }
}

extension KaraokeArtistFinderViewController: KaraokeArtistFinderView {
    
    func reloadArtists(){
        tableView.reloadData()
    }
    
    func setupControlPanel(){
        karaokeZoneControlPanel.createTabs(items: sliderItems)
        karaokeZoneControlPanel.backgroundColor = UIColor(named:"main_background_color")
        karaokeZoneControlPanel.backgroundSelected = UIColor.clear
        karaokeZoneControlPanel.backgroundUnselected = UIColor.clear
        karaokeZoneControlPanel.textSelected = .yellow
        karaokeZoneControlPanel.textUnselected = .white
        karaokeZoneControlPanel.delegate = self
        karaokeTypeControlPanel.typeDispatchAction = {type in self.presenter?.changeArtist(type)}
    }
}
