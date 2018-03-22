//
//  KaraokeInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import SwiftyJSON

class KaraokeInteractor {

    // MARK: Properties
    weak var service:KaraokeService?
    weak var output: KaraokeInteractorOutput?
}

extension KaraokeInteractor: KaraokeUseCase {
    
    func fetchKaraoke(limit: Int, offset: Int, query: String) {
        service?.queryAllSong(limit: limit, offset: offset, query: query, result: { (data, response) in
            
            guard let data = data else {
                self.output?.failureKaraokeSearch( "伺服器忙碌中...")
                return
            }
            
            guard let karaokesJSON = JSON(data)["results"].array else {
                self.output?.didSearchedKaroke([])
                return
            }
            var karaokes:[KaraokeSong] = []
            for karaokeJSON in karaokesJSON {
                
                guard let json = karaokeJSON.dictionaryObject,let karaoke = KaraokeSong.from(json) else {return}
                karaokes.append(karaoke)
            }
            self.output?.didSearchedKaroke(karaokes)
        })
    }
}
