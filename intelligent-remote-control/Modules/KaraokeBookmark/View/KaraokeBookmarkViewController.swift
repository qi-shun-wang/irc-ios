//
//  KaraokeBookmarkViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class KaraokeBookmarkViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    var presenter: KaraokeBookmarkPresentation?

    @IBOutlet weak var editPanel: KaraokeBookmarkEditPanel!
    @IBOutlet weak var createPanel: KaraokeBookmarkCreatePanel!
    // MARK: Lifecycle

    @IBOutlet weak var collectionView: UICollectionView!
    
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

extension KaraokeBookmarkViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KaraokeCell", for: indexPath) as! KaraokeCell
        let info = presenter!.cellForRow(at: indexPath, with: tableView.tag)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.numberOfRows(in: section)
    }
    
}

extension KaraokeBookmarkViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter!.didSelectItem(at: indexPath)
    }
    
}

extension KaraokeBookmarkViewController: UICollectionViewDataSource {
  
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KaraokeBookmarkCell", for: indexPath) as! KaraokeBookmarkCell
        let cellInfo = presenter!.cellForItem(at: indexPath)
        cell.backgroundImage.image = UIImage(named:cellInfo.imageName)
        cell.name.text = cellInfo.name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter!.numberOfItems(in: section)
    }
    
}
extension KaraokeBookmarkViewController: KaraokeBookmarkView {
    
    func reloadBookmark() {
        collectionView.reloadData()
    }
    
    func setupActionBinding(){
        createPanel.createDispatch = {text in self.presenter?.didCreateBookmark(name: text)}
        editPanel.textDispatchAction = {text in self.presenter?.didUpdateBookmark(name: text)}
    }
    
    func updateItemBackgroundImage(name:String,at indexPath:IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! KaraokeBookmarkCell
        cell.backgroundImage.image = UIImage(named:name)
    }
    
    func updateEditPanel(name:String) {
        editPanel.name.text = name
    }
    
    func createBookmarkPanel() {
        createPanel.isHidden = false
    }
}
