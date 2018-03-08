//
//  UICircleButton.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class UICircleButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
  
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.masksToBounds = false
        layer.shadowRadius = 1.0
        layer.shadowOpacity = 0.5
        layer.cornerRadius = frame.size.width/2
    }
    

}
