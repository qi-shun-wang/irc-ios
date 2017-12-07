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
    private var direction:TouchDirection = .none {
        didSet{
            touchedArrowImage.image = UIImage(named:direction.fileName)
        }
    }
    private var timer:Timer = Timer()
    var touchedArrowImage = UIImageView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addSubview(touchedArrowImage)
        updateArrow(view: touchedArrowImage)

    }
    
    func updateArrow(view:UIImageView,length:CGFloat = 150){
        view.snp.remakeConstraints { (make) in
            make.width.equalTo(length)
            make.height.equalTo(length)
            make.center.equalTo(self)
        }
    }
    
    @objc func hidingArrow(){
        touchedArrowImage.image = UIImage()
        print(direction)
        //do something for send message to KOD
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(hidingArrow), userInfo: nil, repeats: false)
        
    }
    
    override var shift: (dx: CGFloat, dy: CGFloat) {
        didSet {
            
            if shift.dx > sensitivity {
                direction = .right
            }
            if shift.dx < -sensitivity {
                direction = .left
            }
            if shift.dy < -sensitivity {
                direction = .up
            }
            if shift.dy > sensitivity {
                direction = .down
            }
        }
    }
}
