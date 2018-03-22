//
//  AccountService.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/22.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class AccountService {
    
    let api:Endpoint
    let handler:HTTPHandler
    
    init(endPoint:Endpoint,handler:HTTPHandler) {
        self.api = endPoint
        self.handler = handler
    }
    
}
