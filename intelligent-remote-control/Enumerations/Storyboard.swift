//
//  Storyboard.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

enum Storyboard:String {
    case root = "Root"
    case main = "Main"
    case menu = "Menu"
    
    var string:String {
        return self.rawValue
    }
}
