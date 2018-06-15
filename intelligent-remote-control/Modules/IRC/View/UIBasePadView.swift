//
//  UIBasePadView.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import SnapKit
protocol PositionDelegate {
    func shift(dx:CGFloat,dy:CGFloat)
    func tap()
}
class UIBasePadView: UIView, Vibrational {
    var delegate: VibrationalViewDelegate?
    var positionDelegate:PositionDelegate?
    private var lastLocation = CGPoint()
    var isTap:Bool = false
    var shift:(dx:CGFloat,dy:CGFloat) = (0,0) {
        didSet{
            positionDelegate?.shift(dx: shift.dx, dy: shift.dy)
        }
    }
    var title = UILabel()
    var touchedDotImage = UIImageView()
    
    func setTitle(with text:String){
        title.text = text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        addSubview(title)
        addSubview(touchedDotImage)
        title.textColor = UIColor.gray.withAlphaComponent(0.5)
        title.alpha = 0.7
        title.textAlignment = .center
        title.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(30)
        }
        updateDot(view: touchedDotImage)
        touchedDotImage.image = UIImage(named:"touch_dot")
        touchedDotImage.isHidden = true
        
    }
    
    func updateDot(view:UIImageView,length:CGFloat = 100){
        view.alpha = 1
        view.snp.remakeConstraints { (make) in
            make.width.equalTo(length)
            make.height.equalTo(length)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            
            updateDot(view:touchedDotImage)
            lastLocation = touch.location(in: self)
            touchedDotImage.center = touch.location(in: self)
            touchedDotImage.isHidden = false
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if location.x < 0 || location.y < 0 || location.x > bounds.width || location.y > bounds.height {
                handleVibration()
                return
            }
            let dx = location.x - lastLocation.x
            let dy = location.y - lastLocation.y
            if !isTap {
                shift = (dx,dy)
            }
            
            touchedDotImage.center = CGPoint(
                x: dx + touchedDotImage.center.x,
                y: dy + touchedDotImage.center.y)
            lastLocation = touch.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTap {
            positionDelegate?.tap()
        }
        UIView.animate(withDuration: 0.5) {
            self.touchedDotImage.alpha = 0
            
        }
    }
    
}
