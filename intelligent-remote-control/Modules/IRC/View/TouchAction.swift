//
//  TouchDirection.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

enum TouchAction  {
    case none
    case center
    case right
    case left
    case up
    case down
    case vertical(Float)
    case horizontal(Float)
    
    var fileName:String {
        get{
            switch self {
            case .vertical:    return ""
            case .horizontal:    return ""
            case .center:    return ""
            case .none:     return ""
            case .right:    return"touch_arrow_R"
            case .left:     return"touch_arrow_L"
            case .up:       return"touch_arrow_U"
            case .down:     return"touch_arrow_D"
            }
        }
    }
}
