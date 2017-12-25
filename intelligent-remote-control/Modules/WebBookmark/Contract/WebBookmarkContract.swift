//
//  WebBookmarkContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

protocol WebBookmarkView: BaseView {
    // TODO: Declare view methods
    //navigation bar
    func setupNavigationLeftItem(image named:String)
    func setupNavigationRightItem(with title:String)
    func setupNavigationTitle(with text:String)
    func showNavigationBarLeftItem()
    func hideNavigationBarLeftItem()
    //segmented control
    func disableBookmarksSegment()
    func enableBookmarksSegment()
    //search bar
    func setupSearchBarStyle()
    //table view
    func showBookmarksTableView()
    func showHistoryTableView()
    func setupHistoryTableView(tag:Int)
    func setupBookmarksTableView(tag:Int)
    //tool bar
    func setupToolBarLeftItem(title:String)
    func setupToolBarRightItem(title:String)
    func showToolBarLeftItem()
    func hideToolBarLeftItem()
    func reloadHistoryTable()
    func reloadBookmarkTable()
}

protocol WebBookmarkPresentation: BasePresentation {
    // TODO: Declare presentation methods
    func dismiss()
    func pressOnToolBarRightItem()
    func pressOnToolBarLeftItem()
    func switchOnSegment(at index:Int)
    func cellInfo(about tableViewTag:Int,cellForRowAt indexPath:IndexPath) -> (id:String,iconName:String,title:String)
    func numberOfRows(about tableViewTag:Int,in section:Int) -> Int
    func canMoveRow(about tableViewTag:Int,at indexPath:IndexPath) -> Bool
}

protocol WebBookmarkUseCase: class {
    // TODO: Declare use case methods
    func fetchHistory()
    func fetchBookmarks()
}

protocol WebBookmarkInteractorOutput: class {
    // TODO: Declare interactor output methods
    func historyFetched(_ websites:[WebsiteHistory])
    func bookmarksFetched(_ websites:[Bookmark])
    
}

protocol WebBookmarkWireframe: class {
    // TODO: Declare wireframe methods
    func dismiss()
}


