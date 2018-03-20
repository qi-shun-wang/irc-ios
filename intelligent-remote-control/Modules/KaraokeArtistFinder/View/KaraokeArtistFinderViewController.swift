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
    
    @IBOutlet weak var karaokeTypeControlPanel: KaraokeTypeControlPanel!
    @IBOutlet weak var karaokeZoneControlPanel: TabbedSlider!
    var sliderItems:[Tab] = [Tab(title: "台灣"),
                       Tab(title: "香港"),
                       Tab(title: "中國"),
                       Tab(title: "歐美"),
                       Tab(title: "亞洲")
    ]
    var presenter: KaraokeArtistFinderPresentation?
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
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
}

extension KaraokeArtistFinderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistCell
        let cellInfo = presenter!.cellForRow(at: indexPath)
        cell.title.text = cellInfo
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(in: section)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension KaraokeArtistFinderViewController: KaraokeArtistFinderView {
    
    func setupControlPanel(){
        karaokeZoneControlPanel.createTabs(items: sliderItems)
        karaokeZoneControlPanel.backgroundColor = UIColor(named:"main_background_color")
        karaokeZoneControlPanel.backgroundSelected = UIColor.clear
        karaokeZoneControlPanel.backgroundUnselected = UIColor.clear
        karaokeZoneControlPanel.textSelected = .yellow
        karaokeZoneControlPanel.textUnselected = .white
        
    }
}