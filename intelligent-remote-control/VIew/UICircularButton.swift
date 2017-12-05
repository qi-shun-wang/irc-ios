//
//  UICircularButton.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class UICircularButton: UIButton {
 
    var circularPath:UIBezierPath?
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let result = (circularPath?.contains(point))!
        print(result)
        return result
    }
    override func draw(_ rect: CGRect) {
        print(rect)
        // PATH
        let bp = UIBezierPath()
        bp.lineCapStyle = .round
        bp.lineJoinStyle = .round
        bp.move(to: CGPoint(x:85.36, y:14.64))
        bp.addCurve(to: CGPoint(x:85.36, y:85.36), controlPoint1:CGPoint(x:104.88, y:34.17), controlPoint2:CGPoint(x:104.88, y:65.83))
        bp.addCurve(to: CGPoint(x:14.64, y:85.36), controlPoint1:CGPoint(x:65.83, y:104.88), controlPoint2:CGPoint(x:34.17, y:104.88))
        bp.addCurve(to: CGPoint(x:14.64, y:14.64), controlPoint1:CGPoint(x:-4.88, y:65.83), controlPoint2:CGPoint(x:-4.88, y:34.17))
        bp.addCurve(to: CGPoint(x:85.36, y:14.64), controlPoint1:CGPoint(x:34.17, y:-4.88), controlPoint2:CGPoint(x:65.83, y:-4.88))
        bp.close()
        circularPath = bp
    }
}
