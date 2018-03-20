//
//  KaraokeBookmarkCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/20.
//  Copyright © 2018年 ising99. All rights reserved.
//

import SnapKit

class KaraokeBookmarkCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        name.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.left.equalToSuperview().offset(2)
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
        }
    }
}
