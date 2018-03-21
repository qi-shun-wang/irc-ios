//
//  ArtistCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/20.
//  Copyright © 2018年 ising99. All rights reserved.
//

import SnapKit

class ArtistCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalTo(subtitle.snp.top).offset(-2)
            make.right.equalTo(icon.snp.left).offset(-8)
        }
        
        subtitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalTo(icon.snp.left).offset(-8)
        }
        
        icon.contentMode = .scaleAspectFit
        icon.snp.makeConstraints { (make) in
            
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
            make.width.equalTo(snp.height).multipliedBy(0.5)
            make.height.equalTo(snp.height).multipliedBy(0.5)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
