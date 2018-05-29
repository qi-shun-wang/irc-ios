//
//  KaraokeArtistFinderPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class KaraokeArtistFinderPresenter {

    // MARK: Properties

    weak var view: KaraokeArtistFinderView?
    var router: KaraokeArtistFinderWireframe?
    var interactor: KaraokeArtistFinderUseCase?
    var artists:[Artist] = []
   
    var currentZoneType:Int = 1 {
        didSet{
            artists = []
            view?.reloadArtists()
            interactor?.fetchArtists(limit: 1000, offset: 0, artistType:currentArtistType, zone: currentZoneType)
        }
    }
    
    var currentArtistType:Int = 1 {
        didSet{
            artists = []
            view?.reloadArtists()
            interactor?.fetchArtists(limit: 1000, offset: 0, artistType:currentArtistType, zone: currentZoneType)
        }
    }
    
}

extension KaraokeArtistFinderPresenter: KaraokeArtistFinderPresentation {
    
    func viewWillDisappear() {
        
    }
    
    func didSelectRow(at indexPath: IndexPath, with tableViewTag: Int) {
        router?.pushToKaraokeFinder(with:artists[indexPath.row])
    }
    
    func numberOfRows(in section: Int) -> Int {
        return artists.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> (title: String,subtitle:String) {
        let artist = artists[indexPath.row]
        return (artist.name,"擁有 \(artist.songAmount) 首歌曲")
    }
    
    func navigateBack() {
        router?.navigateBack()
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupNavigationLeftItem(image: "navigation_back_white_icon", title: "")
        view?.setupControlPanel()
        interactor?.fetchArtists(limit: 1000, offset: 0, artistType: 1, zone: 1)
        view?.showLoading()
    }
    
    func changeArtist(_ type: Int){
        view?.showLoading()
        currentArtistType = type
    }
    func changeZone(_ type: Int) {
        view?.showLoading()
        currentZoneType = type
    }
}

extension KaraokeArtistFinderPresenter: KaraokeArtistFinderInteractorOutput {
    
    func failureFetchedArtists(with message: String) {
        print("---->",message)
    }
    
    func didFetched(_ artists: [Artist], from start: Int, to end: Int) {
        //todo:must check length
        self.artists.insert(contentsOf: artists, at: start)
        view?.reloadArtists()
        view?.hideLoading()
    }
   
}
