//
//  MediaShareVideosViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/6.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareVideosViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties

    @IBOutlet weak var tips: UIView!
    @IBOutlet weak var videosCollectionView: UICollectionView!
    var presenter: MediaShareVideosPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
         presenter?.stopVideoCast()
    }
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {}
    
    override func setupNavigationRightItem(image named: String, title text: String) {}
    
}

extension MediaShareVideosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        presenter?.didSelectItem(at: indexPath)
    
    }
    
}

extension MediaShareVideosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter!.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoThumbnailCell", for: indexPath) as! VideoThumbnailCell
        presenter!.itemInfo(at: indexPath, { (image, info) in
            guard let image = image else {return}
            item.thumbnail.image = image as? UIImage

        })
        return item
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension MediaShareVideosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        // flow layout have all the important info like spacing, inset of collection view cell, fetch it to find out the attributes specified in xib file
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return CGSize()
        }
        
        // subtract section left/ right insets mentioned in xib view
        
        let widthAvailbleForAllItems =  (collectionView.frame.width - flowLayout.sectionInset.left - flowLayout.sectionInset.right)
        
        // Suppose we have to create nColunmns
        // widthForOneItem achieved by sunbtracting item spacing if any
        let nColumns:CGFloat = 3
        let widthForOneItem = widthAvailbleForAllItems/nColumns - flowLayout.minimumInteritemSpacing
        
        
        // here height is mentioned in xib file or storyboard
        return CGSize(width: CGFloat(widthForOneItem), height:CGFloat(widthForOneItem))
        //        return CGSize(width: CGFloat(widthForOneItem), height:(flowLayout.itemSize.height))
        
        
    }
}

extension MediaShareVideosViewController: MediaShareVideosView {
    func fetchedPhotoSize() -> Size? {
        if let layout = videosCollectionView!.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellSize = layout.itemSize
            return CGSize(width: cellSize.width, height: cellSize.height)
        }
        return nil
    }
    
    func reloadVideosCollectionView() {
        videosCollectionView.reloadData()
    }
    
    func showTips() {
        tips.isHidden = false
    }
    
    func hideTips() {
        tips.isHidden = true
    }
}
