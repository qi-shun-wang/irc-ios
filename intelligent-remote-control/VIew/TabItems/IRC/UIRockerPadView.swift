//
//  UIRockerPadView.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/12.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class UIRockerPadView: UIView,Vibrational {
    var delegate: VibrationalViewDelegate?
    
    private var timer:Timer = Timer()
    private var lastLocation = CGPoint()
    
    var shift:(dx:CGFloat,dy:CGFloat) = (0,0)
    
    var dotImageView = UIImageView()
    var backgroundImageView:UIImageView = UIImageView()
    @IBInspectable var backgroundImage:UIImage = UIImage() {
        didSet {
            backgroundImageView.contentMode = .scaleAspectFit
            backgroundImageView.image = backgroundImage
        }
    }
    @IBInspectable var dotImage:UIImage = UIImage() {
        didSet {
            dotImageView.contentMode = .scaleAspectFit
            dotImageView.image = dotImage
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //        clipsToBounds = true
        
        addSubview(backgroundImageView)
        addSubview(dotImageView)
        updateBackground(view:backgroundImageView)
        updateDot(view: dotImageView)
        
    }
    func updateBackground(view:UIImageView){
        
        view.snp.remakeConstraints { (make) in
            make.leading.equalTo(snp.leading)
            make.trailing.equalTo(snp.trailing)
            make.top.equalTo(snp.top)
            make.bottom.equalTo(snp.bottom)
            
        }
    }
    func updateDot(view:UIImageView,length:CGFloat = 100){
        
        view.snp.remakeConstraints { (make) in
            make.leading.equalTo(snp.leading).offset(8)
            make.trailing.equalTo(snp.trailing).offset(-8)
            make.top.equalTo(snp.top).offset(8)
            make.bottom.equalTo(snp.bottom).offset(-8)
            make.center.equalTo(snp.center)
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            updateDot(view:dotImageView)
            lastLocation = touch.location(in: self)
            dotImageView.center = touch.location(in: self)
            
        }
    }
    lazy var radius:CGFloat = dotImageView.frame.width/2
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let dx = location.x - lastLocation.x
            let dy = location.y - lastLocation.y
            if innerCircularPath!.contains(location) {
                
                
                dotImageView.center = CGPoint(
                    x: dx + dotImageView.center.x,
                    y: dy + dotImageView.center.y)
                
                shift = (dx,dy)
                lastLocation = location
            }else {
                print((location.x,location.y))
                print((dx,dy))
                
                if location.y < 0 && location.x > 0 {
                    
                }
            }
            
            
        }
    }
    
    @objc func centerRocker() {
        UIView.animate(withDuration: 0) {
            self.dotImageView.frame = self.backgroundImageView.frame
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(centerRocker), userInfo: nil, repeats: false)
        
    }
    
    
    private var innerCircularPath:UIBezierPath?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let length:CGFloat = rect.width
        let r = length/2
        let pX = rect.origin.x + length/2
        let pY = rect.origin.y + rect.height/2
        innerCircularPath = UIBezierPath(
            arcCenter: CGPoint(x: pX,y: pY)
            , radius: r
            , startAngle: CGFloat(0)
            , endAngle:CGFloat(Double.pi * 2)
            , clockwise: true)
        innerCircularPath?.close()
        //        UIColor.red.set()
        //        innerCircularPath?.fill()
    }
}
