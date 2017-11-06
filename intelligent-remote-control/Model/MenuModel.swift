//
//  MenuModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuItem : NSObject {
    var itemTitle:String
    var storyboard:Storyboard
    
    init(named title:String,at storyboard :Storyboard) {
        self.itemTitle = title
        self.storyboard = storyboard
    }
    
}
