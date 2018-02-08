//
//  UPPBasicDevice+DMR.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/10.
//  Copyright © 2018年 ising99. All rights reserved.
//

import CocoaUPnP

extension UPPBasicDevice: DMR {
    var name: String {
        get{
            return self.friendlyName
        }
        
    }
    var ip: String {
        get {
            return self.baseURL.host ?? ""
        }
    }
    var isConnected: Bool {
        get {
            return false
        }
    }
}
