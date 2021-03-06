//
//  Endpoint.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/21.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

struct Endpoint {
    
    private let host:String
    private let schema:String
    private let api_path:String
    private let port:UInt?
    
    init(schema:String = "https", host:String,port:UInt?, api_path:String = ""){
        self.schema = schema
        self.host = host
        self.port = port
        self.api_path = api_path
    }
    
    // MARK: Karaoke Service's remote url.
    func queryArtists(limit:Int, offset:Int, artist_type:Int, zone:Int) -> String {
        return schema + "://" + host + "\(port == nil ? "": ":\(port!)")/" + api_path + "artists?limit=\(limit)&offset=\(offset)&artist_type=\(artist_type)&zone=\(zone)"
    }
    
    func querySong(by artist_id:Int, limit:Int, offset:Int, query_mode:Int) -> String {
        return schema + "://" + host + "\(port == nil ? "": ":\(port!)")/" + api_path + "song?query_mode=\(query_mode)&artist_id=\(artist_id)&limit=\(limit)&offset=\(offset)"
    }
    
    func queryAllSong(limit:Int, offset:Int, query:String) -> String {
        return schema + "://" + host + "\(port == nil ? "": ":\(port!)")/" + api_path + "song/all?limit=\(limit)&offset=\(offset)&q=\(query)"
    }
    // MARK: (User Session) Karaoke Service's remote url.
    func queryAllKaraokeBookmark(limit:Int, offset:Int, query:String) -> String {
        return schema + "://" + host + "\(port == nil ? "": ":\(port!)")/" + api_path + "user/karaoke/bookmarks/all?limit=\(limit)&offset=\(offset)"
    }
    
    
    // MARK: Account Service's remote url.
    func signin() -> String {
        return schema + "://" + host + "\(port == nil ? "": ":\(port!)")/" + api_path + "user/signin"
    }
    
    func signout() -> String {
        return schema + "://" + host + "\(port == nil ? "": ":\(port!)")/" + api_path + "user/signout"
    }
    
    func register() -> String {
        return schema + "://" + host + "\(port == nil ? "": ":\(port!)")/" + api_path + "user/register"
    }
    
    func checkAccount() -> String {
        return schema + "://" + host + "\(port == nil ? "": ":\(port!)")/" + api_path + "user/register/check"
    }
    
    func userProfile() -> String {
        return schema + "://" + host + "\(port == nil ? "": ":\(port!)")/" + api_path + "user/profile"
    }

}
