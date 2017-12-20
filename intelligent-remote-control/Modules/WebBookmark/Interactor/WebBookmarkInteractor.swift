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
}

extension WebBookmarkInteractor: WebBookmarkUseCase {
    // TODO: Implement use case methods
    func fetchHistory() {
        output?.historyFetched([])
    }
    
    func fetchBookmarks() {
        output?.bookmarksFetched([])
    }
}
