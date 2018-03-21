//
//  KaraokeFinderPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class KaraokeFinderPresenter {
    
    // MARK: Properties
    var artist:Artist?
    weak var view: KaraokeFinderView?
    var router: KaraokeFinderWireframe?
    var interactor: KaraokeFinderUseCase?
    var karaokes:[KaraokeSong] = []
}

extension KaraokeFinderPresenter: KaraokeFinderPresentation {
    
    func navigateBack() {
        router?.navigateBack()
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupNavigationLeftItem(image: "navigation_back_white_icon", title: "")
        view?.setupTitle(text: artist?.name ?? "No Name")
        interactor?.fetchSong(by: artist?.id ?? 0, limit: 1000, offset: 0)
    }
    
    func numberOfRows(in section: Int, with tableViewTag: Int) -> Int {
        //        if shouldShowSearchResults {
        //            return searchedArray.count
        //        }else {
        return karaokes.count
        //        }
    }
    
    func cellForRow(at indexPath: IndexPath, with tableViewTag: Int) -> (name: String, artist: String, signText: String, signText2: String, signColor: String, signColor2: String, signHidden: Bool, sign2Hidden: Bool) {
        let info:KaraokeSong
        //        if shouldShowSearchResults {
        //            info = searchedArray[indexPath.row]
        //        } else {
        info = karaokes[indexPath.row]
        //        }
        let red = "karaoke_red"
        let green = "karaoke_green"
        let sign = "MV"
        let sign2 = "導"
        switch info.type {
        case .is9:return (info.name, info.artist, sign,sign2, red, green, true, false)
        case .mp4:return (info.name, info.artist, sign,sign2, red, green, false, true)
        case .mic:return (info.name, info.artist, sign,sign2, red, green, true, true)
        }
     }
    
}

extension KaraokeFinderPresenter: KaraokeFinderInteractorOutput {
    
    func didFetched(_ karaoke: [KaraokeSong], from start: Int, to end: Int) {
        //todo:must check length
        self.karaokes.insert(contentsOf: karaoke, at: start)
        view?.reloadKaraokes()
        view?.hideLoading()
    }
    
    func failureFetchedSong(with text: String) {
        print("---->",text)
    }
}
