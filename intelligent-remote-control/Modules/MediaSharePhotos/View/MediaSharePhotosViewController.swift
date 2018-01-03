//
//  MediaSharePhotosViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaSharePhotosViewController: BaseViewController, StoryboardLoadable {

    // MARK: Properties
    private var segment:UISegmentedControl!
    var presenter: MediaSharePhotosPresentation?

    @IBOutlet weak var videosCollectionView: UICollectionView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    // MARK: Lifecycle
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    
    @objc private func photosIndexChanged(_ sender: UISegmentedControl){
        presenter?.switchOnSegment(at: sender.selectedSegmentIndex)
    }
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {}
    
    override func setupNavigationRightItem(image named: String, title text: String) {}
    
}

extension MediaSharePhotosViewController: UICollectionViewDelegate {
    
}
extension MediaSharePhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        item.photo.image = UIImage(named:"test")
        return item
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
}

extension MediaSharePhotosViewController: UICollectionViewDelegateFlowLayout {
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

extension MediaSharePhotosViewController: MediaSharePhotosView {
   
    // TODO: implement view output methods
    func setupSegment() {
        segment = UISegmentedControl(items: ["照片", "影片"])
        segment.addTarget(self, action: #selector(photosIndexChanged), for: UIControlEvents.valueChanged)
        segment.sizeToFit()
        segment.tintColor = UIColor(red:0.99, green:0.00, blue:0.25, alpha:1.00)
        segment.selectedSegmentIndex = 0
        segment.setTitleTextAttributes([NSAttributedStringKey.font:  UIFont.systemFont(ofSize: 20)], for: .normal)
        navigationItem.titleView = segment
    }
    
    func setupVideosCollectionView(tag: Int) {
        videosCollectionView.tag = tag
        
    }
    
    func setupPhotosCollectionView(tag: Int) {
        photosCollectionView.tag = tag
    }
    
    func showPhotosCollectionView() {
        videosCollectionView.isHidden = true
        photosCollectionView.isHidden = false
    }
    
    func showVideosCollectionView() {
        videosCollectionView.isHidden = false
        photosCollectionView.isHidden = true
        
    }
    
    func setupNavigationToolBarLeftItem(image named: String, title text: String) {
        
        let left = UIBarButtonItem(image: UIImage(named:named)?.withRenderingMode(.alwaysOriginal),
                                   style: .plain,
                                   target: navigationController,
                                   action: #selector(MediaShareNavigationController.performCast))
        
        let right = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [left,right]
    }
    
}
