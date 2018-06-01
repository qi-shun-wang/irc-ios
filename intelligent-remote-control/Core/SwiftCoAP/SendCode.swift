//
//  SendCode.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/21.
//  Copyright © 2018年 ising99. All rights reserved.
//
import Foundation

enum SendCode:Int {
    
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
    
    case KEYCODE_APPRECIATE = 630
    
    case KEYCODE_BACK = 158
    
    case KEYCODE_CHANNEL_DOWN = 403
    
    case KEYCODE_CHANNEL_UP = 402
    
    case KEYCODE_DEL = 399
    
    case KEYCODE_DPAD_CENTER = 352
    
    case KEYCODE_DPAD_DOWN = 108
    
    case KEYCODE_DPAD_LEFT = 105
    
    case KEYCODE_DPAD_RIGHT = 106
    
    case KEYCODE_DPAD_UP = 103
    
    case KEYCODE_ECHODOWN = 567
    
    case KEYCODE_ECHOUP = 569
    
    case KEYCODE_EPG = 365
    
    case KEYCODE_FORWARD_DEL = 398
    
    case KEYCODE_HOME = 631
    
    case KEYCODE_INFO = 358
    
    case KEYCODE_INSERT_SONG = 625
    
    case KEYCODE_LANGUAGE_SWITCH = 368
    
    case KEYCODE_MAN_WOMEN = 628
    
    case KEYCODE_MEDIA_AUDIO_TRACK = 574
    
    case KEYCODE_MEDIA_FAST_FORWARD = 208
    
    case KEYCODE_MEDIA_PLAY_PAUSE = 207
    
    case KEYCODE_MEDIA_RECORD = 167
    
    case KEYCODE_MEDIA_REWIND = 168
    
    case KEYCODE_MEDIA_STOP = 128
    
    case KEYCODE_MENU = 357
    
    case KEYCODE_MICDOWN = 573
    
    case KEYCODE_MICUP = 572
    
    case KEYCODE_MUSICDOWN = 570
    
    case KEYCODE_MUSICUP = 565
    
    case KEYCODE_PAGE_DOWN = 109
    
    case KEYCODE_PAGE_UP = 104
    
    case KEYCODE_PAIRING = 632
    
    case KEYCODE_PASS_SONG = 624
    
    case KEYCODE_PLAY_CONTROL = 627
    
    case KEYCODE_POWER = 116
    
    case KEYCODE_PROG_BLUE = 401
    
    case KEYCODE_PROG_YELLOW = 400
    
    case KEYCODE_RECORD = 629
    
    case KEYCODE_RESET = 568
    
    case KEYCODE_SUBTITLE = 370
    
    case KEYCODE_TUNING = 626
    
    case KEYCODE_VOCAL = 566
    
    case KEYCODE_VOD = 571
    
    case KEYCODE_VOLUME_DOWN = 114
    
    case KEYCODE_VOLUME_MUTE = 113
    
    case KEYCODE_VOLUME_UP = 115
    
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
        default:return nil
        }
    }
}
