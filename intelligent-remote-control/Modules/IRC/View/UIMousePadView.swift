//
//  UIMousePadView.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import SnapKit

class UIMousePadView: UIBasePadView {
    
    private let sensitivity:CGFloat = 5
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
    }
    override var shift: (dx: CGFloat, dy: CGFloat)
        {
        didSet{
            
            if shift.dx == 0.0 && shift.dy == 0.0 && !isFirstTap {
                positionDelegate?.tap()
            }
            else
            {
                positionDelegate?.shift(dx: shift.dx, dy: shift.dy)
            }
        }
    }
    
}
