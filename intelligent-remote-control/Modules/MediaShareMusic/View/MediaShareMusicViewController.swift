//
//  MediaShareMusicViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareMusicViewController: BaseViewController, StoryboardLoadable {
    
    // MARK: Properties
    private var segment:UISegmentedControl!
    var presenter: MediaShareMusicPresentation?
    
    @IBOutlet weak var playlistTableView: UITableView!
    @IBOutlet weak var albumsCollectionView: UICollectionView!
    @IBOutlet weak var songsTableView: UITableView!
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {
        let left = UIBarButtonItem(image: UIImage(named:named)?.withRenderingMode(.alwaysOriginal),
                                   style: .plain,
                                   target: self,
                                   action: #selector(backAction)
        )
        
        navigationItem.leftBarButtonItem = left
    }
    
    override func setupNavigationRightItem(image named: String, title text: String) {}
    @objc private func backAction(){
        presenter?.navigateBack()
    }
    @objc private func musicIndexChanged(_ sender: UISegmentedControl){
        presenter?.switchOnSegment(at: sender.selectedSegmentIndex)
    }

}

extension MediaShareMusicViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRow(about: tableView.tag, at: indexPath)
    }
}

extension MediaShareMusicViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellInfo = presenter?.cellInfo(about: tableView.tag, at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
        cell.imageView?.image = cellInfo?.image as? UIImage
        cell.textLabel?.text = cellInfo?.title
        cell.detailTextLabel?.text = cellInfo?.subtitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(about: tableView.tag, in: section)
    }
    
}

extension MediaShareMusicViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath)
    }
    
}

extension MediaShareMusicViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter!.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "MusicCell", for: indexPath) as! MusicCollectionViewCell
        let itemInfo = presenter!.itemInfo(at: indexPath)
        item.title.text = itemInfo.title
        item.subtitle.text = itemInfo.subtitle
        item.artworkImage.image = itemInfo.image as? UIImage
        
        return item
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension MediaShareMusicViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // flow layout have all the important info like spacing, inset of collection view cell, fetch it to find out the attributes specified in xib file
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        // subtract section left/ right insets mentioned in xib view
        let widthAvailbleForAllItems =  (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right)
        
        // Suppose we have to create nColunmns
        // widthForOneItem achieved by sunbtracting item spacing if any
        let nColumns:CGFloat = 2
        let widthForOneItem = widthAvailbleForAllItems/nColumns - flowLayout.minimumInteritemSpacing
        
        // here height is mentioned in xib file or storyboard
        return CGSize(width: CGFloat(widthForOneItem), height:(flowLayout.itemSize.height))
    }
}


extension MediaShareMusicViewController: MediaShareMusicView {
    
    // TODO: implement view output methods
    func setupSegment() {
        segment = UISegmentedControl(items: ["播放清單", "專輯","歌曲"])
        segment.addTarget(self, action: #selector(musicIndexChanged), for: UIControlEvents.valueChanged)
        segment.sizeToFit()
        segment.tintColor = UIColor(red:0.99, green:0.00, blue:0.25, alpha:1.00)
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes([NSAttributedStringKey.font:  UIFont.systemFont(ofSize: 20)], for: .normal)
        navigationItem.titleView = segment
        
    }
    
    func setupPlaylistTableView(tag: Int) {
        playlistTableView.tag = tag
    }
    
    func setupSongsTableView(tag: Int) {
        songsTableView.tag = tag
    }
    
    func showAlbumsCollectionView() {
        albumsCollectionView.isHidden = false
        songsTableView.isHidden = true
        playlistTableView.isHidden = true
    }
    
    func showSongsTableView() {
        songsTableView.isHidden = false
        playlistTableView.isHidden = true
        albumsCollectionView.isHidden = true
    }
    
    func showPlaylistTableView() {
        playlistTableView.isHidden = false
        songsTableView.isHidden = true
        albumsCollectionView.isHidden = true
    }
    
     func fetchedPhotoSize() -> Size? {
        if let layout = albumsCollectionView!.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellSize = layout.itemSize
            return CGSize(width: cellSize.width, height: cellSize.height)
        }
        return nil
    }
    
    func reloadAlbumsCollectionView() {
        albumsCollectionView.reloadData()
    }
    
    func reloadSongsTableView() {
        songsTableView.reloadData()
    }
    
    func reloadPlaylistTableView() {
        playlistTableView.reloadData()
    }
    
}
