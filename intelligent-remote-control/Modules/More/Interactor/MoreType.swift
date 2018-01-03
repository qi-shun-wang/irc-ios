//
//  MoreType.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

enum MoreType: MoreTypeProtocol {
    
    func getTitle() -> String {
        switch self {
        case .clouds:return "雲端硬碟"
        case .mediaShare:return "媒體分享"
        case .toneAssistant:return "定調助手"
        case .appManager:return "應用程式管理"
        case .massageAssistant:return "按摩助手(iOS)"
        }
    }
    
    func getImageName() -> String {
        switch self {
        case .clouds:return "more_clouds_icon"
        case .mediaShare:return "more_folder_icon"
        case .toneAssistant:return "more_assistant_icon"
        case .appManager:return "more_manager_icon"
        case .massageAssistant:return "more_exclamation_icon"
        }
    }
    
    case clouds
    case mediaShare
    case toneAssistant
    case appManager
    case massageAssistant
    
}
