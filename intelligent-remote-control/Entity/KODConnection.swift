//
//  KODConnection.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/22.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class KODConnection:NSObject {
    
    let id:String
    let ip:String
    let name:String
    
    init(id:String,ip:String,name:String) {
        self.id = id
        self.ip = ip
        self.name = name
    }
}

extension KODConnection {
    
    func getModel() -> MenuModel {
        return MenuModel(title: self.name, subTitle: self.ip, iconName: "radio_icon", connectionStatus: "等待連線")
    }
}
