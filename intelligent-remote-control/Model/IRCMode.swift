//
//  IRCMode.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/5.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

struct IRCMode {
    var name:String {
        get {return self.type.name}
    }
    var iconFileName:String {
        get {return self.type.fileName}
    }
    
    let type:IRCType
    internal enum IRCType {
        case normal
        case touch
        case mouse
        case keyboard
        case game
        var fileName: String {
            switch self {
            case .normal:   return "irc_mode_normal_icon"
            case .touch:    return "irc_mode_touch_icon"
            case .mouse:    return "irc_mode_mouse_icon"
            case .keyboard: return "irc_mode_keyboard_icon"
            case .game:     return "irc_mode_game_icon"
            }
        }
        var name:String {
            switch self {
            case .normal:   return "一般模式"
            case .touch:    return "觸控模式"
            case .mouse:    return "滑鼠模式"
            case .keyboard: return "鍵盤模式"
            case .game:     return "遊戲模式"
            }
        }
    }
}
