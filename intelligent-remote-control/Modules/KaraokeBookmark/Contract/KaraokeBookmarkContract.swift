//
//  KaraokeBookmarkContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol KaraokeBookmarkView: BaseView {
    func updateItemBackgroundImage(name:String,at indexPath:IndexPath)
    func updateEditPanel(name:String)
    func createBookmarkPanel()
    func reloadBookmark()
    func setupActionBinding()
}

protocol KaraokeBookmarkPresentation: BasePresentation {
    func navigateBack()
    func numberOfRows(in section: Int) -> Int
    func cellForRow(at indexPath: IndexPath, with tableViewTag: Int) -> (
        name: String,
        artist: String,
        signText: String,
        signText2: String,
        signColor: String,
        signColor2: String,
        signHidden: Bool,
        sign2Hidden: Bool)
    func numberOfItems(in section: Int) -> Int
    func cellForItem(at indexPath: IndexPath) -> (name:String, imageName:String)
    func didSelectItem(at indexPath: IndexPath)
    func didUpdateBookmark(name:String)
    func didCreateBookmark(name:String)
}

protocol KaraokeBookmarkUseCase: class {
    // TODO: Declare use case methods
}

protocol KaraokeBookmarkInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol KaraokeBookmarkWireframe: class {
    func navigateBack()
}
