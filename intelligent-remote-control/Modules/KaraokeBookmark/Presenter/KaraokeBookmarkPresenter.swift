//
//  KaraokeBookmarkPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class KaraokeBookmarkPresenter {
    
    // MARK: Properties
    
    weak var view: KaraokeBookmarkView?
    var router: KaraokeBookmarkWireframe?
    var interactor: KaraokeBookmarkUseCase?
    var bookmark:[KaraokeBookmark] = [
        KaraokeBookmark(name:"我的破音Ｋ哥神曲"),
        KaraokeBookmark(name:"我的嗨哥神曲"),
        KaraokeBookmark(name:"我的卡哥神曲"),
        ]
    
    
    var karaokeArray:[Karaoke] = [
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: true),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: true),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: true, hasGuideVocal: false),
        Karaoke(name: "白天不懂黑的夜", artist: "納蘭", hasMV: false, hasGuideVocal: false)
    ]
    
    fileprivate let selectedImageName:String = "karaoke_bookmark_selected"
    fileprivate let unselectedImageName:String = "karaoke_bookmark_unselected"
    fileprivate let addImageName:String = "karaoke_bookmark_add"
    
    var currentSelected:IndexPath = IndexPath(item: 0, section: 0) {
        didSet {
            view?.updateItemBackgroundImage(name: unselectedImageName, at: oldValue)
        }
        willSet {
            view?.updateItemBackgroundImage(name: selectedImageName, at: newValue)
        }
    }
}

extension KaraokeBookmarkPresenter: KaraokeBookmarkPresentation {
   
    func viewWillDisappear() {
        
    }
    
    func didCreateBookmark(name: String) {
        bookmark.append(KaraokeBookmark(name: name))
        view?.reloadBookmark()
        
    }
    
    func didUpdateBookmark(name: String) {
        bookmark[currentSelected.item] = KaraokeBookmark(name: name)
        view?.reloadBookmark()
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupNavigationLeftItem(image: "navigation_back_white_icon", title: "")
        view?.updateEditPanel(name: bookmark.first?.name ?? "")
        view?.setupActionBinding()
    }
    
    func navigateBack() {
        router?.navigateBack()
    }
    
    func numberOfRows(in section: Int) -> Int {
        return karaokeArray.count
    }
    
    func cellForRow(at indexPath: IndexPath, with tableViewTag: Int) -> (name: String, artist: String, signText: String, signText2: String, signColor: String, signColor2: String, signHidden: Bool, sign2Hidden: Bool) {
        let info:Karaoke = karaokeArray[indexPath.row]
        
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
    
    func numberOfItems(in section: Int) -> Int {
        return bookmark.count + 1
    }
    
    func cellForItem(at indexPath: IndexPath) -> (name: String, imageName: String) {
        
        if indexPath.item > bookmark.count - 1 {
            return ("",addImageName)
        }
        let mark = bookmark[indexPath.item]
        if indexPath == currentSelected {
            return (mark.name,selectedImageName)
        }
        return (mark.name,unselectedImageName)
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        if indexPath.item > bookmark.count - 1 {
            //TODO: add new bookmark here
            view?.createBookmarkPanel()
            return
        }
        
        view?.updateEditPanel(name: bookmark[indexPath.item].name)
        indexPath != currentSelected ? currentSelected = indexPath : ()
        
    }
}

extension KaraokeBookmarkPresenter: KaraokeBookmarkInteractorOutput {
    // TODO: implement interactor output methods
}

struct KaraokeBookmark {
    let name:String
}
