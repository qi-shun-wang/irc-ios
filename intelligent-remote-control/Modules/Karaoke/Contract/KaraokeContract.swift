//
//  KaraokeContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol KaraokeView: BaseView {
    
    func reloadTableView()
    func reloadSearchTableView()
    func setupControlPanelView()
    func setupTableViewTag()
}

protocol KaraokePresentation: BasePresentation {
    
    func numberOfRows(in section: Int, with tableViewTag: Int) -> Int
    func cellForRow(at indexPath: IndexPath, with tableViewTag: Int) -> (
        name: String,
        artist: String,
        signText: String,
        signText2: String,
        signColor: String,
        signColor2: String,
        signHidden: Bool,
        sign2Hidden: Bool)
    
    func togglePlayingList()
    func heightForHeader(in section:Int,with tableViewTag:Int) -> Int
    func viewForHeader(in section:Int,with tableViewTag:Int) -> (title:String, iconName:String)?
    func navigateToBookmark()
    func navigateToFinder()
    func startSearchMode()
    func stopSearchMode()
    func inputSearchText(_ keyword:String)
}

protocol KaraokeUseCase: class {
    func fetchKaraoke(limit: Int, offset: Int, query: String)
}

protocol KaraokeInteractorOutput: class {
    func didSearchedKaroke(_ karaoke:[KaraokeSong])
    func failureKaraokeSearch(_ message:String)
}

protocol KaraokeWireframe: class {
    // TODO: Declare wireframe methods
    func pushToFinder()
    func pushToBookmark()
}
