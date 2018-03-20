//
//  KaraokeCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import SnapKit

class KaraokeCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var sign: UILabel!
    @IBOutlet weak var sign2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sign.layer.cornerRadius = sign.frame.width/2
        sign2.layer.cornerRadius = sign2.frame.width/2
        
        title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalTo(subtitle.snp.top).offset(-2)
            make.right.equalTo(sign.snp.left).offset(-8)
        }
        
        subtitle.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalTo(sign.snp.left).offset(-8)
        }
        
        sign.snp.makeConstraints { (make) in
            make.right.equalTo(sign2.snp.left).offset(-2)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(snp.width).dividedBy(6)
        }
        
        sign2.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
            make.width.equalTo(snp.width).dividedBy(6)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
