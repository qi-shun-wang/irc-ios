//
//  RepeatMode.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/13.
//  Copyright © 2018年 ising99. All rights reserved.
//

enum RepeatMode:Int {
    case none = 0
    case `repeat` = 1
    case repeatOnce = 2
    
    func next() -> RepeatMode {
        if rawValue < 2 {
          return RepeatMode(rawValue:rawValue + 1)!
        }
        return RepeatMode(rawValue: 0)!
    }
}
