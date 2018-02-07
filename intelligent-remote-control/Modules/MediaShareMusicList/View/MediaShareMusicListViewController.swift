//
//  MediaShareMusicListViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import LNPopupController

class MediaShareMusicListViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    @IBOutlet weak var musicTableView: UITableView!
    var presenter: MediaShareMusicListPresentation?

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
    
    override func setupNavigationRightItem(image named: String, title text: String) {
        
    }
}

extension MediaShareMusicListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         presenter?.didSelectRow(at: indexPath)
    }
}

extension MediaShareMusicListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInfo = presenter?.cellInfo(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
        cell.imageView?.image = cellInfo?.image as? UIImage
        cell.textLabel?.text = cellInfo?.title
        cell.detailTextLabel?.text = cellInfo?.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(in: section)
    }
}

extension MediaShareMusicListViewController: MediaShareMusicListView {
    
    // TODO: implement view output methods
    func reloadSongsTableView() {
        musicTableView.reloadData()
    }
    
    func setupToolBarLeftItem(image named: String, title text: String) {
        
    }
    
    func setupNavigationBarTitle(with text: String) {
        navigationItem.title = text
    }
    
}
