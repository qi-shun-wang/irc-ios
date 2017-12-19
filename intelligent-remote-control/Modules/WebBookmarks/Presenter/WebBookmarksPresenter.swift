//
//  WebBookmarksPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/18.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

enum WebsiteCollectionType: Int {
    case bookmarks
    case history
}

class WebBookmarksPresenter: WebBookmarksPresenterProtocol {
    
    var isEditing: Bool = false
    fileprivate var items:[String] = ["",""]
    fileprivate var historyItems:[String] = ["",""]
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
        print("pressOnToolBarLeftItem")
    }
    
    func startEditing() {
        view?.showToolBarLeftItem()
    }
    
    func stopEditing() {
        view?.hideToolBarLeftItem()
    }
    
    weak var view: WebBookmarksViewProtocol?
    
    var interactor: WebBookmarksInteratorInputProtocol?
    
    var router: WebBookmarksRoutingProtocol?
    
    func viewDiDLoad() {
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
    
    func cellInfo(about tableViewTag: Int, cellForRowAt indexPath: IndexPath) -> (id:String,iconName:String,title:String) {
        return ("WebBookmarksFolderCell","web_bookmark_folder_icon","google")
    }
    func numberOfRows(about tableViewTag: Int, in section: Int) -> Int {
        guard let type = WebsiteCollectionType(rawValue: tableViewTag) else {
            print("WebsiteCollectionType Error:tableViewTag:\(tableViewTag) not supported.")
            return 0
        }
        switch type{
        case .bookmarks:
            return items.count
        case .history:
            return historyItems.count
        }
    }
    
    func switchOnSegment(at index: Int) {
        guard let type = WebsiteCollectionType(rawValue: index) else {
            print("Bookmarks not support segment index:\(index)")
            return
        }
        currentType = type
    }
}
