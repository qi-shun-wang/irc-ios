//
//  MenuCell.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    //tempary not be used, may be needed in the future
    /*
     fileprivate let lineWidthPercentage: CGFloat = 0.5
     */
    
    @IBOutlet weak var menuCellContainer: UIView!
    @IBOutlet weak var menuConnectionStatus: UILabel!
    @IBOutlet weak var menuSubtitle: UILabel!
    @IBOutlet weak var lowerline: UIView!
    @IBOutlet weak var upperline: UIView!
    @IBOutlet weak var menuTitle: UILabel!
    @IBOutlet weak var menuIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        upperline.isHidden = true
        lowerline.isHidden = true
 
        menuCellContainer.layer.cornerRadius = 10
    }
 
    
}


