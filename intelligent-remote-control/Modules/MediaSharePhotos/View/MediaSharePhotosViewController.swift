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
    var presenter: MediaSharePhotosPresentation?
    
    @IBOutlet weak var mediaControlBtn: UIButton!
    
    @IBOutlet weak var tips: UIView!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    // MARK: Lifecycle
    override func viewDidLoad() {
        presenter?.viewDidLoad()
    }
    override func viewWillDisappear(_ animated: Bool) {
        presenter?.stopImageCast()
    }
    @IBAction func performCast(_ sender: UIButton) {
        presenter?.performImageCast()
    }
    
    override func setupNavigationBarStyle() {
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupNavigationLeftItem(image named: String, title text: String) {}
    
    override func setupNavigationRightItem(image named: String, title text: String) {}
    
}


extension MediaSharePhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let isSelected =  presenter?.didSelectItem(at: indexPath)
        let cell : PhotosCollectionViewCell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell
        isSelected == true ? (cell.selectedBlur.isHidden = false) : (cell.selectedBlur.isHidden = true)
    }
    
}

extension MediaSharePhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter!.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCollectionViewCell", for: indexPath) as! PhotosCollectionViewCell
        presenter!.itemInfo(at: indexPath, { (isSelected) in
            if isSelected {
                item.selectedBlur.isHidden = false
            }else {
                item.selectedBlur.isHidden = true
            }
        }, { (image, info) in
            guard let image = image else {return}
            item.photo.image = image as? UIImage
        })
        
        
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
    
    func reloadPhotosCollectionView() {
        photosCollectionView.reloadData()
    }
    
   
    func fetchedPhotoSize() -> Size? {
        if let layout = photosCollectionView!.collectionViewLayout as? UICollectionViewFlowLayout {
            let cellSize = layout.itemSize
            return CGSize(width: cellSize.width, height: cellSize.height)
        }
        return nil
        
    }
    
    func setupMediaControlToolBar(text:String){
        mediaControlBtn.setTitle(text, for: .normal)
    }
    
    func showTips() {
        tips.isHidden = false
    }
    
    func hideTips() {
        tips.isHidden = true
    }
}

extension UIImage:Image{}

extension CGSize:Size{
    var w: Float {
        get {
            return Float(width)
        }
        set {
            width = CGFloat(newValue)
        }
    }
    
    var h: Float {
        get {
            return Float(height)
        }
        set {
            height = CGFloat(newValue)
        }
    }
    
    
}
