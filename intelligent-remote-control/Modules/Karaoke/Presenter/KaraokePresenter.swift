//
//  KaraokePresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class KaraokePresenter {
    
    // MARK: Properties
    fileprivate var shouldShowSearchResults = false
    fileprivate var isPlayingListOpened:Bool = true
    fileprivate var isPlayedListOpened:Bool = true
    var playedKaraokeArray:[KaraokeSong] = [
        KaraokeSong(id: 0, name: "白天不懂黑的夜", type: .mp4, artist: "納蘭"),
        KaraokeSong(id: 0, name: "白天不懂黑的夜", type: .is9, artist: "納蘭"),
        KaraokeSong(id: 0, name: "白天不懂黑的夜", type: .mic, artist: "納蘭")
        
    ]
    var preparedKaraokeList:[KaraokeSong] = [
    ]
    
    var tmpKaraokeList:[KaraokeSong] = []
    var searchedArray:[KaraokeSong] = []
    weak var view: KaraokeView?
    var router: KaraokeWireframe?
    var interactor: KaraokeUseCase?
}

extension KaraokePresenter: KaraokePresentation {
   
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func heightForHeader(in section: Int, with tableViewTag: Int) -> Int {
        if shouldShowSearchResults {
            return 0
        } else {
            return 40
        }
    }
    
    func viewForHeader(in section: Int, with tableViewTag: Int) -> (title: String, iconName: String)? {
        guard !shouldShowSearchResults else {return nil}
        if isPlayingListOpened {
            return ("待唱列表","karaoke_arrow_down_icon")
        } else {
            return ("待唱列表","karaoke_minus_icon")
        }
    }
    
    func viewDidLoad(){
        view?.setupControlPanelView()
        view?.setupTableViewTag()
        preparedKaraokeList.count > 0 ? view?.hideKaraokeTips():view?.showKaraokeTips()
    }
    
    func cellForRow(at indexPath:IndexPath,with tableViewTag:Int) -> (
        name:String,
        artist:String,
        signText:String,
        signText2:String,
        signColor:String,
        signColor2:String,
        signHidden:Bool,
        sign2Hidden:Bool) {
            
            let info:KaraokeSong
            
            if shouldShowSearchResults {
                info = searchedArray[indexPath.row]
            } else {
                info = tmpKaraokeList[indexPath.row]
            }
            
            let red = "karaoke_red"
            let green = "karaoke_green"
            let sign = "原唱"
            let sign2 = "導唱"
            switch info.type {
            case .is9:return (info.name, info.artist, sign,sign2, red, green, true, false)
            case .mp4:return (info.name, info.artist, sign2,sign, green, red, true, false)
            case .mic:return (info.name, info.artist, sign,sign2, red, green, true, true)
            }
    }
    
    func numberOfRows(in section: Int,with tableViewTag:Int)->Int{
        if shouldShowSearchResults {
            return searchedArray.count
        } else {
            return tmpKaraokeList.count
        }
    }
    
    func togglePlayingList() {
        
        if isPlayingListOpened {
            isPlayingListOpened = false
            tmpKaraokeList = []
        } else {
            isPlayingListOpened = true
            tmpKaraokeList = preparedKaraokeList
            
        }
        view?.reloadTableView()
    }
    
    func navigateToFinder() {
        router?.pushToFinder()
    }
    
    func navigateToBookmark() {
        router?.pushToBookmark()
    }
    
    func startSearchMode() {
        shouldShowSearchResults = true
        view?.reloadSearchTableView()
    }
    
    func stopSearchMode() {
        shouldShowSearchResults = false
    }
    
    func inputSearchText(_ keyword:String) {
        interactor?.fetchKaraoke(limit: 1000, offset: 0, query: keyword)
    }
}

extension KaraokePresenter: KaraokeInteractorOutput {
    
    func didSearchedKaroke(_ karaoke: [KaraokeSong]) {
        searchedArray = karaoke
        view?.reloadSearchTableView()
    }
    
    func failureKaraokeSearch(_ message: String) {
        
    }
}
