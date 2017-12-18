//
//  WebHistoryListPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/14.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
///WebHistoryListPresenter contains view logic for preparing content for display (as received from the Interactor) and for reacting to user inputs (by requesting new data from the Interactor).
class WebHistoryListPresenter:WebHistoryListPresenterProtocol{
    
    
    var view: WebHistoryListViewProtocol?
    
    var interactor: WebHistoryListInteratorInputProtocol?
    
    var router: WebHistoryListRoutingProtocol?
    
    func viewDiDLoad() {
        view?.setupNavigationLeftItem(image: "navigation_back_icon")
        view?.setupNavigationRightItem(with: "全部清除")
        view?.setupNavigationTitle(with: "歷史紀錄")
        interactor?.retrieveHistoryList()
    }
    
    func clearAllHistory() {
        
    }
    
    func deleteHistory(for website: WebsiteModel) {
        
    }
 
}


extension WebHistoryListPresenter:WebHistoryListInteratorOutputProtocol{
    func didReceiveHistory(_ websites: [Int:[WebsiteModel]]) {
        view?.showHistoryList(with: websites)
    }
    
    func onError() {
        view?.showError()
    }
    
    
}
