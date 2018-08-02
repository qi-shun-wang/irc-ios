//
//  UITouchPadView.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class UITouchPadView: UIBasePadView {
    var sender:CodeSender?
    private let sensitivity:CGFloat = 10
    private var action:TouchAction = .none {
        didSet{
            touchedArrowImage.image = UIImage(named:action.fileName)
        }
    }
    private var timer:Timer = Timer()
    private var touchedArrowImage = UIImageView()
    private var isScrolling:Bool = false
    
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
        print(action)
        switch action {
        case .vertical(let value):
            sender?.dispatch(code: SendCode.game_axis.THUMB_L_Y, value: value)
        case .horizontal: break
        case .down:
            sender?.dispatch(state: .normal, code: SendCode.KEYCODE_DPAD_DOWN)
        case .up:
            sender?.dispatch(state: .normal, code: SendCode.KEYCODE_DPAD_UP)
        case .right:
            sender?.dispatch(state: .normal, code: SendCode.KEYCODE_DPAD_RIGHT)
        case .left:
            sender?.dispatch(state: .normal, code: SendCode.KEYCODE_DPAD_LEFT)
        case .center:
            sender?.dispatch(state: .normal, code: SendCode.KEYCODE_DPAD_CENTER)
        case .none: break
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        isScrolling = (event?.allTouches?.count ?? 1) == 2
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(hidingArrow), userInfo: nil, repeats: false)
        
    }
    
    override var shift: (dx: CGFloat, dy: CGFloat) {
        didSet {
            if isScrolling {
                action = .vertical(Float(shift.dy))
            } else {
                if shift.dx == 0.0 && shift.dy == 0.0 {
                    action = .center
                    return
                }
                
                if shift.dx > sensitivity {
                    action = .right
                }
                else if shift.dx < -sensitivity {
                    action = .left
                }
                else if shift.dy < -sensitivity {
                    action = .up
                }
                else if shift.dy > sensitivity {
                    action = .down
                }else{
                    action = .none
                }
            }
        }
    }
}
