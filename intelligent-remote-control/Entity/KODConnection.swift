//
//  KODConnection.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/22.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

struct KODConnection:Device {
    
    var address: String
    var name: String
 }

extension KODConnection {
    
    func getModel() -> MenuModel {
        return MenuModel(title: self.name, subTitle: self.address, iconName: "radio_icon", connectionStatus: "等待連線")
    }
}

extension KODConnection :Hashable {
    var hashValue: Int {
        return address.hashValue
    }
    
    static func ==(lhs: KODConnection, rhs: KODConnection) -> Bool {
        return lhs.address == rhs.address
    }
    
    
}
