//
//  EditFolderNameCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/26.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class EditFolderNameCell: UITableViewCell {
    
    @IBOutlet weak var folderName: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        folderName.modifyClearButton(with: UIImage(named:"textfield_clear_btn_icon")!)
        folderName.attributedPlaceholder = NSAttributedString(string: folderName.placeholder!, attributes: [NSAttributedStringKey.foregroundColor : UIColor.lightGray.withAlphaComponent(0.5)])
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
