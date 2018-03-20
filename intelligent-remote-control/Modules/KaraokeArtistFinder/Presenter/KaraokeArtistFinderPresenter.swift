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
    var artist:[String] = ["張友學"]
}

extension KaraokeArtistFinderPresenter: KaraokeArtistFinderPresentation {
    
    func didSelectRow(at indexPath: IndexPath, with tableViewTag: Int) {
        router?.pushToKaraokeFinder()
    }
    
    func numberOfRows(in section: Int) -> Int {
        return artist.count
    }
    
    func cellForRow(at indexPath: IndexPath) -> String {
        return artist[indexPath.row]
    }
    
    func navigateBack() {
        router?.navigateBack()
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupNavigationLeftItem(image: "navigation_back_white_icon", title: "")
        view?.setupControlPanel()
    }
}

extension KaraokeArtistFinderPresenter: KaraokeArtistFinderInteractorOutput {
  
}
