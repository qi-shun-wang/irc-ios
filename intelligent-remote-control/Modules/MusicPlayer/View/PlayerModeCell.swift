//
//  PlayerModeCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/9.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class PlayerModeCell: UITableViewCell {

    @IBOutlet weak var repeatBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        repeatBtn.layer.cornerRadius = 10
        // Initialization code
    }
    var changeRepeatMode:(()->Void)?
    @IBAction func repeatAction(_ sender: UIButton) {
        changeRepeatMode?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
