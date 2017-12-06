//
//  UIBasePadView.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/6.
//  Copyright © 2017年 ising99. All rights reserved.
//

import SnapKit
import AVFoundation
class UIBasePadView: UIView {
    
    private let generator  = UIImpactFeedbackGenerator(style: .heavy)
    private let generator2 = UIImpactFeedbackGenerator(style: .medium)
    private let generator3 = UIImpactFeedbackGenerator(style: .light)
    private let systemSoundID: SystemSoundID = 1105
    var title = UILabel()
    var touchedDotImage = UIImageView()
    var touchedArrowImage = UIImageView()
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
        //        addSwipe()
        title.textColor = UIColor.gray.withAlphaComponent(0.5)
        title.alpha = 0.7
        title.textAlignment = .center
        title.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.width.equalTo(self)
            make.height.equalTo(30)
        }
        
        updateDot()
        touchedDotImage.image = UIImage(named:"touch_dot")
        touchedDotImage.isHidden = true
    }
    
    func updateDot(length:CGFloat = 150){
        touchedDotImage.alpha = 1
        touchedDotImage.snp.remakeConstraints { (make) in
            make.width.equalTo(length)
            make.height.equalTo(length)
            
        }
    }
    var lastLocation = CGPoint()
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            updateDot()
            lastLocation = touch.location(in: self)
            touchedDotImage.center = touch.location(in: self)
            touchedDotImage.isHidden = false
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            touchedDotImage.center = CGPoint(
                x: (location.x - self.lastLocation.x) + touchedDotImage.center.x,
                y: (location.y - self.lastLocation.y) + touchedDotImage.center.y)
            lastLocation = touch.location(in: self)
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 1) {
            self.touchedDotImage.alpha = 0
            
            
        }
    }
    
    func addSwipe() {
        let directions: [UISwipeGestureRecognizerDirection] = [.right, .left, .up, .down]
        for direction in directions {
            let gesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
            gesture.direction = direction
            self.addGestureRecognizer(gesture)
        }
    }
    
    @objc func handleSwipe(sender: UISwipeGestureRecognizer) {
        print(sender.direction)
        performSwipeArrowAnimation(at: sender.location(in: self),with:sender.direction)
        
        
    }
    
    
    func performTouchDotAnimation(at point:CGPoint) {
        //        generator.impactOccurred()
        //        AudioServicesPlaySystemSound (systemSoundID)
        touchedDotImage.center = point
        touchedDotImage.image = UIImage(named:"touch_dot")
        //        UIView.animate(withDuration: 1, animations: {
        self.touchedDotImage.isHidden = false
        //            self.touchedDotImage.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        //        }) { (finished) in
        //            UIView.animate(withDuration: 1, animations: {
        //                self.touchedDotImage.isHidden = true
        //                self.touchedDotImage.transform = CGAffineTransform.identity
        //            })
        //        }
    }
    func performSwipeArrowAnimation(at point:CGPoint,with direction:UISwipeGestureRecognizerDirection) {
        touchedDotImage.center = center
        generator3.impactOccurred()
        AudioServicesPlaySystemSound (systemSoundID)
        let scaleX:CGFloat
        let scaleY:CGFloat
        switch direction {
        case .left:
            touchedDotImage.image = UIImage(named:"touch_arrow_L")
            scaleX = 4
            scaleY = 2
        case .right:
            touchedDotImage.image = UIImage(named:"touch_arrow_R")
            scaleX = 4
            scaleY = 2
        case .up:
            touchedDotImage.image = UIImage(named:"touch_arrow_U")
            scaleX = 2
            scaleY = 4
        case .down:
            touchedDotImage.image = UIImage(named:"touch_arrow_D")
            scaleX = 2
            scaleY = 4
        default:
            scaleX = 0
            scaleY = 0
            break
            
        }
        
        UIView.animate(withDuration: 1, animations: {
            self.touchedDotImage.isHidden = false
            self.touchedDotImage.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            
        }) { (finished) in
            UIView.animate(withDuration: 1, animations: {
                self.touchedDotImage.isHidden = true
                self.touchedDotImage.transform = CGAffineTransform.identity
            })
        }
    }
    
    
}
