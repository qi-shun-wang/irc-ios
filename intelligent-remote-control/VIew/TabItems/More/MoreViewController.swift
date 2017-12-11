//
//  MoreViewController.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/5.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class MoreViewController: BaseViewController {
    var moreItems:[MoreModel] = [
        MoreModel(title:"雲端硬碟",iconFileName:"more_clouds_icon"),
        MoreModel(title:"媒體分享",iconFileName:"more_folder_icon"),
        MoreModel(title:"定調助手",iconFileName:"more_assistant_icon"),
        MoreModel(title:"應用程式管理",iconFileName:"more_manager_icon"),
        MoreModel(title:"按摩助手(iOS)",iconFileName:"more_exclamation_icon"),
        
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
}
extension MoreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 + moreItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NormalCell", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MoreCell", for: indexPath) as! MoreCell
            cell.icon.image = UIImage(named: moreItems[indexPath.row - 1].iconFileName)
            cell.title.text = moreItems[indexPath.row - 1].title
            cell.layer.cornerRadius = 10
            return cell
        }
        
        
    }
    
}

extension MoreViewController: UICollectionViewDelegate {
    
}
extension MoreViewController: UICollectionViewDelegateFlowLayout {
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
        return CGSize(width: CGFloat(widthForOneItem), height:CGFloat(widthForOneItem))
        //        return CGSize(width: CGFloat(widthForOneItem), height:(flowLayout.itemSize.height))
        
        
    }
}
