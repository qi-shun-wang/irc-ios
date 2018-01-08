//
//  WarningBadge.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/8.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class WarningBadge: UIView {

    let warningText:UILabel = UILabel()
    
    var text:String = "" {
        didSet{
            warningText.text = text
        }
    }
    
    override var frame: CGRect {
        didSet {
            warningText.frame = CGRect.init(origin: CGPoint.zero, size: frame.size)
        }
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        warningText.textAlignment = .center
        warningText.textColor = .white
        addSubview(warningText)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
