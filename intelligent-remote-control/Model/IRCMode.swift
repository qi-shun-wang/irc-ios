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
    var lightFileName:String {
        get {return self.type.lightFileName}
    }
    var darkFileName:String {
        get {return self.type.darkFileName}
    }
    
    let type:IRCType
    internal enum IRCType {
        case general
        case normal
        case touch
        case mouse
        case keyboard
        case game
        
        
        var lightFileName: String {
            switch self {
            case .general:  return "btn_remote_light_icon"
            case .normal:   return "btn_remote_light_icon"
            case .touch:    return "btn_touch_light_icon"
            case .mouse:    return "btn_mouse_light_icon"
            case .keyboard: return "btn_keyboard_light_icon"
            case .game:     return "btn_game_light_icon"
            }
        }
        var darkFileName: String {
            switch self {
            case .general:  return "btn_remote_icon"
            case .normal:   return "btn_remote_icon"
            case .touch:    return "btn_touch_icon"
            case .mouse:    return "btn_mouse_icon"
            case .keyboard: return "btn_keyboard_icon"
            case .game:     return "btn_game_icon"
            }
        }
        var fileName: String {
            switch self {
            case .general:  return "irc_mode_normal_icon"
            case .normal:   return "irc_mode_normal_icon"
            case .touch:    return "irc_mode_touch_icon"
            case .mouse:    return "irc_mode_mouse_icon"
            case .keyboard: return "irc_mode_keyboard_icon"
            case .game:     return "irc_mode_game_icon"
            }
        }
        var name:String {
            switch self {
            case .general:  return "一般模式"
            case .normal:   return "精簡模式"
            case .touch:    return "觸控模式"
            case .mouse:    return "滑鼠模式"
            case .keyboard: return "鍵盤模式"
            case .game:     return "遊戲模式"
            }
        }
    }
}
