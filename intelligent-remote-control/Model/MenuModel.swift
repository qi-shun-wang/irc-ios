//
//  MenuModel.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/11/4.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuItem: NSObject {
    var itemTitle:String
    var itemIcon:String
    var storyboard:Storyboard
    var isLastItem:Bool
    var isMainEntry:Bool
    init(named title:String, _ icon:String, isLast:Bool = false, isMainEntry:Bool = false, at storyboard:Storyboard) {
        self.itemTitle = title
        self.itemIcon = icon
        self.storyboard = storyboard
        self.isLastItem = isLast
        self.isMainEntry = isMainEntry
    }
    
}
