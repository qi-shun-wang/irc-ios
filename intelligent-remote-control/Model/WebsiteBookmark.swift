//
//  WebsiteBookmark.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol Bookmark {
    var level:Int{get set}
    var name:String{get}
    var url:String{get}
    var icon:String{get}
}

struct Website:Bookmark {
    var level:Int
    var name: String
    var url: String
    var icon: String
}

struct WebsiteCategory:Bookmark {
    let id:Int
    var level:Int
    var name: String
    var url: String
    var icon: String
}
extension WebsiteCategory:Equatable {
    static func ==(lhs: WebsiteCategory, rhs: WebsiteCategory) -> Bool {
        return lhs.id == rhs.id
    }
}
