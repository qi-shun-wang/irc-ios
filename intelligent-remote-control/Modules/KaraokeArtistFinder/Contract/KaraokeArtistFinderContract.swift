//
//  KaraokeArtistFinderContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol KaraokeArtistFinderView: BaseView {
    func setupControlPanel()
    func reloadArtists()
}

protocol KaraokeArtistFinderPresentation: BasePresentation {
    func navigateBack()
    func cellForRow(at indexPath: IndexPath) -> String
    func numberOfRows(in section: Int) -> Int
    func didSelectRow(at indexPath: IndexPath ,with tableViewTag: Int)
    func changeZone(_ type: Int)
    func changeArtist(_ type: Int)
}

protocol KaraokeArtistFinderUseCase: class {
    
    func fetchArtists(limit: Int, offset: Int, artistType: Int, zone: Int)
    
}

protocol KaraokeArtistFinderInteractorOutput: class {
    // TODO: Declare interactor output methods
    func didFetched(_ artists:[Artist],from start:Int,to end:Int)
    func failureFetchedArtists(with message:String)
}

protocol KaraokeArtistFinderWireframe: class {
    func navigateBack()
    func pushToKaraokeFinder(with artist: Artist)
}
