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
    func viewForHeader(in section:Int,with tableViewTag:Int) -> (title:String, iconName:String)
    func navigateToBookmark()
    func navigateToFinder()
}

protocol KaraokeUseCase: class {
    // TODO: Declare use case methods
}

protocol KaraokeInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol KaraokeWireframe: class {
    // TODO: Declare wireframe methods
    func pushToFinder()
    func pushToBookmark()
}
