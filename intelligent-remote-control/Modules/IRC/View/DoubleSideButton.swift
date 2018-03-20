//
//  DoubleSideButton.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/20.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

class DoubleSideButton: UIButton {
    
    public var upSideAction:Callback?
    public var downSideAction:Callback?
    
    @IBInspectable var upPart:UIImage?
    @IBInspectable var downPart:UIImage?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touchedY = touches.first?.location(in: self).y else {return}
        calculate(touchedY)
    }
    
    func calculate(_ y:CGFloat) {
        if y > bounds.maxY/2 {
            setImage(downPart, for: .highlighted)
            downSideAction?()
        } else {
            setImage(upPart, for: .highlighted)
            upSideAction?()
        }
    }
}
