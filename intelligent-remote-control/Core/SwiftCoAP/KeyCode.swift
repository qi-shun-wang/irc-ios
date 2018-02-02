//
//  KeyCode.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/29.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol KeyCodeSender {
    func forward(code:KeyCode)
}

enum KeyCode:Int {
    case KEYCODE_DPAD_UP = 103
    case KEYCODE_DPAD_LEFT = 105
    case KEYCODE_DPAD_RIGHT = 106
    case KEYCODE_DPAD_DOWN = 108
    case KEYCODE_ENTER = 352
    
    case KEYCODE_VOLUME_MUTE = 113
    case KEYCODE_VOLUME_DOWN = 114
    case KEYCODE_VOLUME_UP = 115
    case KEYCODE_POWER = 116
    case KEYCODE_BACK = 158
    case KEYCODE_MENU = 357
    
//    case KEYCODE_DPAD_UP = 19
//    case KEYCODE_DPAD_DOWN = 20
//    case KEYCODE_DPAD_LEFT = 21
//    case KEYCODE_DPAD_RIGHT = 22
//    case KEYCODE_ENTER  = 66
    
//    case KEYCODE_MENU = 82
//    case KEYCODE_BACK = 4
//    case KEYCODE_POWER = 26
    case KEYCODE_KOD_PLUS = 303
//
//    case KEYCODE_VOLUME_MUTE = 164
//    case KEYCODE_VOLUME_UP = 24
//    case KEYCODE_VOLUME_DOWN = 25
    
    
    case KEYCODE_TONING = 298
    case KEYCODE_BROADCAST  = 299
    case KEYCODE_MAN_WOMEN = 300
    case KEYCODE_RECORD = 301
    case KEYCODE_APPRECIATE = 302
    
    case KEYCODE_MEDIA_PLAY_PAUSE = 85
    case KEYCODE_LANGUAGE_SWITCH = 204
    
    
    case KEYCODE_PAGE_UP = 92
    case KEYCODE_PAGE_DOWN = 93
    
    case KEYCODE_0 = 7
    case KEYCODE_1 = 8
    case KEYCODE_2 = 9
    case KEYCODE_3 = 10
    case KEYCODE_4 = 11
    case KEYCODE_5 = 12
    case KEYCODE_6 = 13
    case KEYCODE_7 = 14
    case KEYCODE_8 = 15
    case KEYCODE_9 = 16
    
    case KEYCODE_INSERT_SONG = 297
    case KEYCODE_PASS_SONG = 296
}
