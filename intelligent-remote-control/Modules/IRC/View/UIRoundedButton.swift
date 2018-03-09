//
//  UIRoundedButton.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class UIRoundedButton: UIButton {

    @IBInspectable var cornerRadius:CGFloat = 10 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    @IBInspectable var shadowRadius:CGFloat = 10 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }

    @IBInspectable var shadowColor:UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
    }
    

}
