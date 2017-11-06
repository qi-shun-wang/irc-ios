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
    case irc = "IRC"
    case intro = "Introduction"
    case cloudDrive = "CloudDrive"
    case mediaShare = "MediaShare"
    case tone = "Tone"
    case tips = "Tips"
    case setting = "Setting"
    
    var name:String {
        return self.rawValue
    }
}
