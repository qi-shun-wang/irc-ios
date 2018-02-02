//
//  BlendScreenImage.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/1.
//  Copyright © 2018年 ising99. All rights reserved.
//

import UIKit

extension UIImage {
    func setBlending(tintColor:UIColor) ->UIImage  {
        tintColor.setFill()
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0)
        let bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIRectFill(bounds)
        draw(in: bounds, blendMode: .screen, alpha: 1)
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
       return img
    }
}
