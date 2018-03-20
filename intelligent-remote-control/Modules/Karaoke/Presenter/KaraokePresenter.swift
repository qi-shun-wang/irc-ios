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
    var shouldShowSearchResults = false
    fileprivate var isPlayingListOpened:Bool = true
    fileprivate var isPlayedListOpened:Bool = true
    var playedKaraokeArray:[Karaoke] = [
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: true, hasGuideVocal: true),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: false, hasGuideVocal: true),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: true, hasGuideVocal: false),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: false, hasGuideVocal: false)
        
    ]
    
    var karaokeArray:[Karaoke] = [
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: true),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: true),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: false),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: false)
    ]
    
    var searchedArray:[Karaoke] = [
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: true, hasGuideVocal: true),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: false, hasGuideVocal: true),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: true, hasGuideVocal: false),
        Karaoke(name: "白不天懂的夜黑", artist: "納蘭", hasMV: false, hasGuideVocal: false)
    ]
    weak var view: KaraokeView?
    var router: KaraokeWireframe?
    var interactor: KaraokeUseCase?
}

extension KaraokePresenter: KaraokePresentation {
    
    func viewForHeader(in section: Int, with tableViewTag: Int) -> (title: String, iconName: String) {
        if isPlayingListOpened {
            return ("待唱列表","karaoke_arrow_down_icon")
        } else {
            return ("待唱列表","karaoke_minus_icon")
        }
    }
    
    func viewDidLoad(){
        
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
            let info:Karaoke
            if shouldShowSearchResults {
                info = searchedArray[indexPath.row]
            } else {
                info = karaokeArray[indexPath.row]
            }
            let red = "karaoke_red"
            let green = "karaoke_green"
            let sign = "MV"
            let sign2 = "導"
            if info.hasGuideVocal && info.hasMV {
                return (info.name, info.artist, sign,sign2, red, green, false, false)
            } else {
                return (info.name, info.artist, sign, info.hasGuideVocal ? sign:sign2, red,info.hasGuideVocal ? red:green, true, false)
            }
    }
    
    func numberOfRows(in section: Int,with tableViewTag:Int)->Int{
        if shouldShowSearchResults {
            return searchedArray.count
        }else {
            return karaokeArray.count
        }
    }
    
    func togglePlayingList() {
        
        if isPlayingListOpened {
            isPlayingListOpened = false
            karaokeArray = []
        } else {
            isPlayingListOpened = true
            karaokeArray = [
                Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: true),
                Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: true),
                Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: false),
                Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: false)
            ]
            
        }
        view?.reloadTableView()
    }
    
    func navigateToFinder() {
        router?.pushToFinder()
    }
    
    func navigateToBookmark() {
        router?.pushToBookmark()
    }
    func navigateBack(){}
}

extension KaraokePresenter: KaraokeInteractorOutput {
    // TODO: implement interactor output methods
}
