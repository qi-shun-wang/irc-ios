//
//  AboutCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/23.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class AboutCell: UITableViewCell {

    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var indicator: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
