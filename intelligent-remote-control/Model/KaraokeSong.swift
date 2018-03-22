//
//  KaraokeSong.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/21.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

struct Karaoke {
    let name:String
    let artist:String
    let hasMV:Bool
    let hasGuideVocal:Bool
}

struct KaraokeSong {
  
    let id:Int
    let name:String
    let type:KaraokeFileType
    let artist:String
    
    static func from(_ json:[String:Any]) -> KaraokeSong? {
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let typeStr = json["type"] as? String,
            let type = KaraokeFileType(rawValue: typeStr) ,
            let artist = json["artist_name"] as? String else {return nil}
        return KaraokeSong(id: id, name:name , type: type,artist:artist)
    }
    
    func toJSON() -> [String:Any] {
        var json:[String:Any] = [:]
        json["id"] = self.id
        json["name"] = self.name
        json["type"] = self.type.rawValue
        json["artist_name"] = self.artist
        return json
    }
}

enum KaraokeFileType: String {
    case is9 = "iS9"
    case mp4 = "mp4"
    case mic = "mic"
}
