//
//  KaraokeFinderInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import SwiftyJSON

class KaraokeFinderInteractor {

    // MARK: Properties
    weak var service:KaraokeService?
    weak var output: KaraokeFinderInteractorOutput?
}

extension KaraokeFinderInteractor: KaraokeFinderUseCase {
    
    func fetchSong(by artist_id: Int, limit: Int, offset: Int) {
        service?.querySong(by: artist_id, limit: limit, offset: offset, query_mode: 1, result: { (data, response) in
            
            guard let data = data else {
                self.output?.failureFetchedSong(with: "伺服器忙碌中...")
                return
            }
            
            guard let karaokesJSON = JSON(data)["results"].array else {
                self.output?.didFetched([], from: offset, to: limit - offset)
                return
            }
            var karaokes:[KaraokeSong] = []
            for karaokeJSON in karaokesJSON {
                
                guard let json = karaokeJSON.dictionaryObject,let karaoke = KaraokeSong.from(json) else {return}
                karaokes.append(karaoke)
            }
            self.output?.didFetched(karaokes, from: offset, to: limit - offset)
        })
    }
}
