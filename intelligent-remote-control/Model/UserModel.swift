//
//  UserModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/7.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class UserModel : NSObject {
    var userName:String
    var userID:String
    
    
    init(userName:String, userID:String) {
        self.userName = userName
        self.userID = userID
    }
    
}
