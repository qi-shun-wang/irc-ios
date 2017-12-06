//
//  UITouchPadView.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class UITouchPadView: UIBasePadView {
    private let sensitivity:CGFloat = 10
    var timer:Timer = Timer()
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @objc func hidingArrow(){
        touchedArrowImage.isHidden = true
        //do something for send message to KOD
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(hidingArrow), userInfo: nil, repeats: false)
        
    }
    override var shift: (dx: CGFloat, dy: CGFloat) {
        willSet {
            //            print("---->willSet:\(shift)")
            
        }
        didSet {
            timer.invalidate()
            touchedArrowImage.isHidden = false
            //            print("---->didSet:\(shift)")
            if shift.dx > sensitivity {
                print("Right")
                touchedArrowImage.image = UIImage(named:"touch_arrow_R")
            }
            if shift.dx < -sensitivity {
                touchedArrowImage.image = UIImage(named:"touch_arrow_L")
                print("Left")
            }
            if shift.dy < -sensitivity {
                print("Up")
                touchedArrowImage.image = UIImage(named:"touch_arrow_U")
            }
            if shift.dy > sensitivity {
                print("Down")
                touchedArrowImage.image = UIImage(named:"touch_arrow_D")
            }
        }
    }
}
