//
//  Storyboard.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/10/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

enum Storyboard:String {
    
    case base = "Base"
    case main = "Main"
    case menu = "Menu"
    case irc = "IRC"
    case intro = "Introduction"
    case cloudDrive = "CloudDrive"
    case mediaShare = "MediaShare"
    case tone = "Tone"
    case tips = "Tips"
    case setting = "Setting"
    case karaoke = "Karaoke"
    case movie = "Movie"
    case more = "More"
    
    var name:String {
        return self.rawValue
    }
}
