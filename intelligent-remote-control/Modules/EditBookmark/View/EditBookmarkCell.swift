//
//  EditBookmarkCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/27.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class EditBookmarkCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UITextField!
    @IBOutlet weak var address: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
