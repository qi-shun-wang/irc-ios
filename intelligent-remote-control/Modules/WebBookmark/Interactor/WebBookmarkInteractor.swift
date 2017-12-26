//
//  WebBookmarkInteractor.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class WebBookmarkInteractor {
    
    // MARK: Properties
    
    weak var output: WebBookmarkInteractorOutput?
    
    deinit {
        print("deinit---->\(self)")
    }
}

extension WebBookmarkInteractor: WebBookmarkUseCase {
    // TODO: Implement use case methods
    func fetchHistory() {
        let fakeData:[WebsiteHistory] = [
            WebsiteHistory(name:"Google",url:"www.google.com",icon:"web_bookmark_file_icon"),
            WebsiteHistory(name:"Yahoo",url:"www.yahoo.com",icon:"web_bookmark_file_icon"),
            WebsiteHistory(name:"Apple",url:"www.apple.com",icon:"web_bookmark_file_icon")
        ]
        output?.historyFetched(fakeData)
    }
    
    func fetchBookmarks() {
        let fakeData:[Bookmark] = [
            Website(level: 0, name: "Yahoo", url: "www.yahoo.com", icon: "web_bookmark_file_icon"),
            WebsiteCategory(id: 0, level: 0,name: "我的分類", url: "", icon: "web_bookmark_folder_icon"),
            Website(level: 0,name: "Google", url: "www.google.com", icon: "web_bookmark_file_icon"),
            WebsiteCategory(id: 1, level: 0,name: "你的分類", url: "", icon: "web_bookmark_folder_icon"),
            Website(level: 0,name: "Apple", url: "www.apple.com", icon: "web_bookmark_file_icon"),
            WebsiteCategory(id: 2, level: 0,name: "她的分類", url: "", icon: "web_bookmark_folder_icon")
        ]
        output?.bookmarksFetched(fakeData)
    }
}
