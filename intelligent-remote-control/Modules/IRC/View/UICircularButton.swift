//
//  UICircularButton.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit
import AVFoundation

class UICircularButton: UIButton ,Vibrational{
    var delegate: VibrationalViewDelegate?
    var sender:CodeSender?
    private let innerRadiusPercentage:CGFloat = 0.4
    private var innerCircularPath:UIBezierPath?
    private var upArrowPath:UIBezierPath?
    private var leftArrowPath:UIBezierPath?
    private var rightArrowPath:UIBezierPath?
    private var downArrowPath:UIBezierPath?
    
    @IBInspectable
    var innerCircleClickable:Bool = false
    @IBInspectable
    lazy var innerCircleImage:UIImage = UIImage()
    @IBInspectable
    lazy var upArrowImage:UIImage = UIImage()
    @IBInspectable
    lazy var downArrowImage:UIImage = UIImage()
    @IBInspectable
    lazy var leftArrowImage:UIImage = UIImage()
    @IBInspectable
    lazy var rightArrowImage:UIImage = UIImage()
    
    private let generator = UIImpactFeedbackGenerator(style: .light)
    private let systemSoundID: SystemSoundID = 1105

    override init(frame: CGRect) {
        super.init(frame: frame)
        initGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initGesture()
    }
    
    private func initGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(normalTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        addGestureRecognizer(tapGesture)
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap(_:)))
        addGestureRecognizer(longGesture)
    }
    
    @objc func normalTap(_ sender: UIGestureRecognizer){
        perform(state: .normal)
    }
    
    @objc func longTap(_ sender: UIGestureRecognizer){
        if sender.state == .ended {
            perform(state: .end)
        }
        else if sender.state == .began {
            perform(state: .began)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let point = touches.first?.location(in: self) else {return}
        calculate(point)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        print(rect)
        // PATH
        
        let length:CGFloat = rect.width
        let pX = rect.origin.x + length/2
        let pY = rect.origin.y + rect.height/2
        
        //r1:radius of inner circle;r2:redius of outer circle
        let r1 = length/2*innerRadiusPercentage
        let r2 = length/2
        
        innerCircularPath = UIBezierPath(
            arcCenter: CGPoint(x: pX,y: pY)
            , radius: r1
            , startAngle: CGFloat(0)
            , endAngle:CGFloat(Double.pi * 2)
            , clockwise: true)
        innerCircularPath?.close()
        
        upArrowPath = UIBezierPath()
        upArrowPath?.addArc(
            withCenter:  CGPoint(x: pX,y: pY)
            , radius: r2
            , startAngle: CGFloat(-Double.pi/4)
            , endAngle: CGFloat(-Double.pi*3/4)
            , clockwise: false)
        
        upArrowPath?.addArc(
            withCenter:  CGPoint(x: pX,y: pY)
            , radius: r1
            , startAngle: CGFloat(-Double.pi*3/4)
            , endAngle: CGFloat(-Double.pi/4)
            , clockwise: true)
        
        upArrowPath?.close()
        
        leftArrowPath = UIBezierPath()
        leftArrowPath?.addArc(
            withCenter:  CGPoint(x: pX,y: pY)
            , radius: r2
            , startAngle: CGFloat(-Double.pi*3/4)
            , endAngle: CGFloat(Double.pi*3/4)
            , clockwise: false)
        
        leftArrowPath?.addArc(
            withCenter:  CGPoint(x: pX,y: pY)
            , radius: r1
            , startAngle: CGFloat(Double.pi*3/4)
            , endAngle: CGFloat(-Double.pi*3/4)
            , clockwise: true)
        
        leftArrowPath?.close()
        
        downArrowPath = UIBezierPath()
        downArrowPath?.addArc(
            withCenter:  CGPoint(x: pX,y: pY)
            , radius: r2
            , startAngle: CGFloat(Double.pi*3/4)
            , endAngle: CGFloat(Double.pi/4)
            , clockwise: false)
        
        downArrowPath?.addArc(
            withCenter:  CGPoint(x: pX,y: pY)
            , radius: r1
            , startAngle: CGFloat(Double.pi/4)
            , endAngle: CGFloat(Double.pi*3/4)
            , clockwise: true)
        
        downArrowPath?.close()
        
        
        rightArrowPath = UIBezierPath()
        rightArrowPath?.addArc(
            withCenter:  CGPoint(x: pX,y: pY)
            , radius: r2
            , startAngle: CGFloat(Double.pi/4)
            , endAngle: CGFloat(-Double.pi/4)
            , clockwise: false)
        
        rightArrowPath?.addArc(
            withCenter:  CGPoint(x: pX,y: pY)
            , radius: r1
            , startAngle: CGFloat(-Double.pi/4)
            , endAngle: CGFloat(Double.pi/4)
            , clockwise: true)
        
        rightArrowPath?.close()
        
    }
    
    var isInnerCircle:Bool = false {didSet {if isInnerCircle {setImage(innerCircleImage, for: UIControlState.highlighted)}}}
    var isUpArrow:Bool = false {didSet {if isUpArrow { setImage(upArrowImage, for: UIControlState.highlighted)}}}
    var isDownArrow:Bool = false {didSet {if isDownArrow {setImage(downArrowImage, for: UIControlState.highlighted)}}}
    var isLeftArrow:Bool = false {didSet {if isLeftArrow {setImage(leftArrowImage, for: UIControlState.highlighted)}}}
    var isRightArrow:Bool = false {didSet {if isRightArrow {setImage(rightArrowImage, for: UIControlState.highlighted)}}}
    
    
    //helper
    func calculate(_ point:CGPoint) {
        isInnerCircle = (innerCircularPath?.contains(point))! && innerCircleClickable
        isUpArrow = (upArrowPath?.contains(point))!
        isDownArrow = (downArrowPath?.contains(point))!
        isLeftArrow = (leftArrowPath?.contains(point))!
        isRightArrow = (rightArrowPath?.contains(point))!
    }
    
    func perform(state:PerformState) {
        
        if isInnerCircle {
            handleVibration()
            sender?.dispatch(state: state, code: SendCode.KEYCODE_DPAD_CENTER)
        } else {
            AudioServicesPlaySystemSound (systemSoundID)
            handleVibration(with: generator)
            if isUpArrow {sender?.dispatch(state: state, code: SendCode.KEYCODE_DPAD_UP)}
            if isDownArrow {sender?.dispatch(state: state, code: SendCode.KEYCODE_DPAD_DOWN)}
            if isLeftArrow {sender?.dispatch(state: state, code: SendCode.KEYCODE_DPAD_LEFT)}
            if isRightArrow {sender?.dispatch(state: state, code: SendCode.KEYCODE_DPAD_RIGHT)}
        }
    }
    
    
}
