//
//  KaraokeArtistFinderInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import SwiftyJSON
class KaraokeArtistFinderInteractor {

    // MARK: Properties

    weak var output: KaraokeArtistFinderInteractorOutput?
    weak var service: KaraokeService?
}

extension KaraokeArtistFinderInteractor: KaraokeArtistFinderUseCase {
    
    func fetchArtists(limit: Int, offset: Int, artistType: Int, zone: Int) {
        service?.queryArtists(limit: limit, offset: offset, artist_type: artistType, zone: zone, result: { (data, response) in
            
            guard let data = data else {
                self.output?.failureFetchedArtists(with: "伺服器忙碌中...")
                return
            }
            
            guard let artistsJSON = JSON(data)["results"].array else {
                self.output?.didFetched([], from: offset, to: limit - offset)
                return
            }
            var artists:[Artist] = []
            for artistJSON in artistsJSON {
                
                guard let json = artistJSON.dictionaryObject,let artist = Artist.from(json) else {return}
                artists.append(artist)
            }
            self.output?.didFetched(artists, from: offset, to: limit - offset)
        })
    }
    
}
