//
//  SendCode.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/21.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
//linux
enum SendCode:Int {
    
    case KEYCODE_DPAD_UP = 103
    case KEYCODE_DPAD_DOWN = 108
    case KEYCODE_DPAD_LEFT = 105
    case KEYCODE_DPAD_RIGHT = 106
    case KEYCODE_ENTER  = 352
  
    case KEYCODE_MENU = 357
    case KEYCODE_BACK = 158
    case KEYCODE_POWER = 116
    //    case KEYCODE_KOD_PLUS = 303
    case KEYCODE_KOD_PLUS = 365
    case KEYCODE_VOLUME_MUTE = 113
    case KEYCODE_VOLUME_UP = 115
    case KEYCODE_VOLUME_DOWN = 114
    case KEYCODE_MEDIA_PLAY_PAUSE = 207
    //    case KEYCODE_TONING = 298
    //    case KEYCODE_BROADCAST  = 299
    //    case KEYCODE_MAN_WOMEN = 300
    //    case KEYCODE_RECORD = 301
    //    case KEYCODE_APPRECIATE = 302
    //
    //    case KEYCODE_MEDIA_PLAY_PAUSE = 85
    //    case KEYCODE_LANGUAGE_SWITCH = 204
    //
    
    case KEYCODE_PAGE_UP = 403
    case KEYCODE_PAGE_DOWN = 402
    
    case KEYCODE_DELETE = 165
    case KEYCODE_0 = 11
    case KEYCODE_1 = 2
    case KEYCODE_2 = 3
    case KEYCODE_3 = 4
    case KEYCODE_4 = 5
    case KEYCODE_5 = 6
    case KEYCODE_6 = 7
    case KEYCODE_7 = 8
    case KEYCODE_8 = 9
    case KEYCODE_9 = 10
    
    static func numberConvert(from senderTag:Int) -> SendCode? {
        switch senderTag {
        case 0: return .KEYCODE_0
        case 1: return .KEYCODE_1
        case 2: return .KEYCODE_2
        case 3: return .KEYCODE_3
        case 4: return .KEYCODE_4
        case 5: return .KEYCODE_5
        case 6: return .KEYCODE_6
        case 7: return .KEYCODE_7
        case 8: return .KEYCODE_8
        case 9: return .KEYCODE_9
        default:
            return nil
        }
    }
    //    case KEYCODE_INSERT_SONG = 297
    //    case KEYCODE_PASS_SONG = 296
}
