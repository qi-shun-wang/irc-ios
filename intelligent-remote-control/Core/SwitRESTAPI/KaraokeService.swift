//
//  KaraokeService.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/21.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class KaraokeService {
    
    let api:Endpoint
    let handler:HTTPHandler
    
    init(endPoint:Endpoint,handler:HTTPHandler) {
        self.api = endPoint
        self.handler = handler
    }
    
    func queryArtists(limit: Int, offset: Int, artist_type: Int, zone: Int, result: @escaping (Data?,HTTPURLResponse?) -> Void) {
        let url = api.queryArtists(limit: limit, offset: offset, artist_type: artist_type, zone: zone)
        handler.get(url: url, result: result)
    }
    
    func querySong(by artist_id: Int, limit: Int, offset: Int, query_mode: Int, result: @escaping (Data?,HTTPURLResponse?) -> Void) {
        let url = api.querySong(by: artist_id, limit: limit, offset: offset, query_mode: query_mode)
        handler.get(url: url, result: result)
    }
    
    func queryAllSong(limit: Int, offset: Int, query: String, result: @escaping (Data?,HTTPURLResponse?) -> Void) {
        let url = api.queryAllSong(limit: limit, offset: offset, query: query)
        handler.get(url: url, result: result)
    }
}
