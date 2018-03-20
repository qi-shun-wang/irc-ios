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
    
    weak var view: KaraokeFinderView?
    var router: KaraokeFinderWireframe?
    var interactor: KaraokeFinderUseCase?
    var karaokeArray:[Karaoke] = [
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: true),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: true),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: false),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: false)
    ]
}

extension KaraokeFinderPresenter: KaraokeFinderPresentation {
    
    func navigateBack() {
        router?.navigateBack()
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupNavigationLeftItem(image: "navigation_back_white_icon", title: "")
    }
    
    func numberOfRows(in section: Int, with tableViewTag: Int) -> Int {
        //        if shouldShowSearchResults {
        //            return searchedArray.count
        //        }else {
        return karaokeArray.count
        //        }
    }
    
    func cellForRow(at indexPath: IndexPath, with tableViewTag: Int) -> (name: String, artist: String, signText: String, signText2: String, signColor: String, signColor2: String, signHidden: Bool, sign2Hidden: Bool) {
        let info:Karaoke
        //        if shouldShowSearchResults {
        //            info = searchedArray[indexPath.row]
        //        } else {
        info = karaokeArray[indexPath.row]
        //        }
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
    
    // TODO: implement presentation methods
}

extension KaraokeFinderPresenter: KaraokeFinderInteractorOutput {
    // TODO: implement interactor output methods
}
