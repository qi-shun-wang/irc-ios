//
//  WebBookmarkPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
enum WebsiteCollectionType:Int{
    case bookmarks
    case history
}
class WebBookmarkPresenter {

    // MARK: Properties

    weak var view: WebBookmarkView?
    var router: WebBookmarkWireframe?
    var interactor: WebBookmarkUseCase?
    
    fileprivate var isEditing: Bool = false
    fileprivate var bookmarks:[WebsiteBookmark] = []
    fileprivate var history:[WebsiteHistory] = []
    
    fileprivate var currentType:WebsiteCollectionType = .bookmarks {
        didSet {
            switch currentType {
            case .bookmarks:
                view?.showBookmarksTableView()
                view?.setupToolBarRightItem(title: "編輯")
                view?.setupNavigationTitle(with: "書籤")
                print("favorite")
            case .history:
                view?.showHistoryTableView()
                view?.setupToolBarRightItem(title: "清除")
                view?.setupNavigationTitle(with: "歷史紀錄")
                
                print("history")
            }
        }
    }
    
    
}

extension WebBookmarkPresenter: WebBookmarkPresentation {
    
    // TODO: implement presentation methods
    func viewDidLoad() {
        
        view?.setupNavigationRightItem(with: "完成")
        view?.setupNavigationTitle(with: "書籤")
        view?.setupSearchBarStyle()
        view?.setupToolBarLeftItem(title: "新增分類")
        view?.setupToolBarRightItem(title: "編輯")
        view?.hideToolBarLeftItem()
        view?.setupHistoryTableView(tag: WebsiteCollectionType.history.rawValue)
        view?.setupBookmarksTableView(tag: WebsiteCollectionType.bookmarks.rawValue)
    }
    
    func dismiss() {
        router?.dismiss()
    }
    
    func pressOnToolBarRightItem() {
        switch currentType {
        case .bookmarks:
            isEditing = !isEditing
            if isEditing {
                view?.setupToolBarRightItem(title: "完成")
                view?.showToolBarLeftItem()
                view?.hideNavigationBarLeftItem()
                view?.disableBookmarksSegment()
            }else {
                view?.setupToolBarRightItem(title: "編輯")
                view?.hideToolBarLeftItem()
                view?.showNavigationBarLeftItem()
                view?.enableBookmarksSegment()
            }
        case .history:
            return
        }
    }
    
    func pressOnToolBarLeftItem() {
        
    }
    
    func switchOnSegment(at index: Int) {
        guard let type = WebsiteCollectionType(rawValue: index) else {
            print("Bookmarks not support segment index:\(index)")
            return
        }
        currentType = type
    }
    
    func cellInfo(about tableViewTag: Int, cellForRowAt indexPath: IndexPath) -> (id: String, iconName: String, title: String) {
        guard let type = WebsiteCollectionType(rawValue: tableViewTag) else {
            print("WebsiteCollectionType Error:tableViewTag:\(tableViewTag) not supported.")
            return ("","","")
        }
        
        switch type {
        case .bookmarks:
            return ("WebBookmarksFolderCell","web_bookmark_folder_icon","google")
        case .history:
            return ("WebHistoryFileCell","web_bookmark_file_icon","google")
        }
    }
    
    func numberOfRows(about tableViewTag: Int, in section: Int) -> Int {
        guard let type = WebsiteCollectionType(rawValue: tableViewTag) else {
            print("WebsiteCollectionType Error:tableViewTag:\(tableViewTag) not supported.")
            return 0
        }
        switch type{
        case .bookmarks:
            return bookmarks.count
        case .history:
            return history.count
        }
    }
    
    func canMoveRow(about tableViewTag: Int, at indexPath: IndexPath) -> Bool {
        guard let type = WebsiteCollectionType(rawValue: tableViewTag) else {
            print("WebsiteCollectionType Error:tableViewTag:\(tableViewTag) not supported.")
            return false
        }
        switch type{
        case .bookmarks:
            return true
        case .history:
            return false
        }
    }
}

extension WebBookmarkPresenter: WebBookmarkInteractorOutput {
    // TODO: implement interactor output methods
    func historyFetched(_ websites: [WebsiteHistory]) {
        self.history = websites
    }
    
    func bookmarksFetched(_ websites: [WebsiteBookmark]) {
        self.bookmarks = websites
    }
    
}
