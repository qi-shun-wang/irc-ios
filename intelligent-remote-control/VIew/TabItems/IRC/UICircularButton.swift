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
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let isInnerCircle = (innerCircularPath?.contains(point))!
        
        if isInnerCircle && innerCircleClickable {
            setImage(innerCircleImage, for: UIControlState.highlighted)
            AudioServicesPlaySystemSound (systemSoundID)
            handleVibration()
            return isInnerCircle
        }else {
            let isUpArrow = (upArrowPath?.contains(point))!
            let isdownArrow = (downArrowPath?.contains(point))!
            let isleftArrow = (leftArrowPath?.contains(point))!
            let isrightArrow = (rightArrowPath?.contains(point))!
            if isUpArrow {
                setImage(upArrowImage, for: UIControlState.highlighted)
                AudioServicesPlaySystemSound (systemSoundID)
                handleVibration(with: generator)   
                return true
            }
            if isdownArrow {
                setImage(downArrowImage, for: UIControlState.highlighted)
                AudioServicesPlaySystemSound (systemSoundID)
                handleVibration(with: generator)
                return true
            }
            if isleftArrow {
                setImage(leftArrowImage, for: UIControlState.highlighted)
                AudioServicesPlaySystemSound (systemSoundID)
                handleVibration(with: generator)
                return true
            }
            if isrightArrow {
                setImage(rightArrowImage, for: UIControlState.highlighted)
                AudioServicesPlaySystemSound (systemSoundID)
                handleVibration(with: generator)
                return true
            }
        }
        return false
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
}
