//
//  SendCode.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/21.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
//linux
/*
 key 116    POWER
 key 113    VOLUME_MUTE
 key 398    FORWARD_DEL
 key 399    DEL
 key 400    LANGUAGE_SWITCH
 key 401    PROG_BLUE
 key 207    MEDIA_PLAY_PAUSE
 key 128    MAN_WOMEN
 key 565    MUSICUP
 key 566    PLAY_CONTROL
 key 167    RECORD
 key 567    ECHODOWN
 key 568    RESET
 key 569    ECHOUP
 key 168    MEDIA_REWIND
 key 208    MEDIA_FAST_FORWARD
 key 570    MUSICDOWN
 key 574    TUNING
 key 357    MENU
 key 571    APPRECIATE
 key 103    DPAD_UP
 key 105    DPAD_LEFT
 key 352    DPAD_CENTER
 key 106    DPAD_RIGHT
 key 108    DPAD_DOWN
 key 158    BACK
 key 365    HOME
 key 115    VOLUME_UP
 key 114    VOLUME_DOWN
 key 572    MICUP
 key 573    MICDOWN
 key 402    PAGE_UP
 key 403    PAGE_DOWN
 key   2    1
 key   3    2
 key   4    3
 key   5    4
 key   6    5
 key   7    6
 key   8    7
 key   9    8
 key  10    9
 key  11    0
 key 358    PASS_SONG
 key 370    INSERT_SONG
 
 * */
enum SendCode:Int {
    
    case KEYCODE_DPAD_UP = 103
    case KEYCODE_DPAD_DOWN = 108
    case KEYCODE_DPAD_LEFT = 105
    case KEYCODE_DPAD_RIGHT = 106
    case KEYCODE_ENTER  = 352
    
    case KEYCODE_MENU = 357
    case KEYCODE_BACK = 158
    case KEYCODE_POWER = 116
    
    case KEYCODE_KOD_PLUS = 365
    case KEYCODE_VOLUME_MUTE = 113
    case KEYCODE_VOLUME_UP = 115
    case KEYCODE_VOLUME_DOWN = 114
    case KEYCODE_MEDIA_PLAY_PAUSE = 207
    
    case KEYCODE_PASS_SONG = 358
    case KEYCODE_INSERT_SONG = 370
    case KEYCODE_TUNING = 574
    case KEYCODE_PLAY_CONTROL = 566
    case KEYCODE_MAN_WOMEN = 128
    case KEYCODE_RECORD = 167
    case KEYCODE_APPRECIATE = 571
    case KEYCODE_LANGUAGE_SWITCH = 400
    
    case KEYCODE_PAGE_UP = 402
    case KEYCODE_PAGE_DOWN = 403
    
    case KEYCODE_DELETE = 399
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
}
