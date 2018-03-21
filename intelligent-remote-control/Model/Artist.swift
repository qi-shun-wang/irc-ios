//
//  Artist.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/21.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

struct Artist {
    let id:Int
    let name:String
    let songAmount:Int

    static func from(_ json:[String:Any]) -> Artist? {
        guard let id = json["id"] as? Int , let name = json["name"] as? String , let amount = json["song_amount"] as? Int else {return nil}
        return Artist(id: id, name:name , songAmount: amount)
    }
    
    func toJSON() -> [String:Any] {
        var json:[String:Any] = [:]
        json["id"] = self.id
        json["name"] = self.name
        json["song_amount"] = self.songAmount
        return json
    }
}

