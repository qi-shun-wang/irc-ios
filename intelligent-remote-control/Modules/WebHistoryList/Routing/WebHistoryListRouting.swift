//
//  WebHistoryListRouting.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/14.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit
///WebHistoryListRouting contains navigation logic for describing which screens are shown in which order.
class WebHistoryListRouting: WebHistoryListRoutingProtocol {
    
    
    static func createHistoryListModule() -> UIViewController {
        
        let view = UIStoryboard(name: "WebBrowser", bundle: Bundle.main)
            .instantiateViewController(withIdentifier: "WebHistoryListView") as! WebHistoryListView
        
        let presenter = WebHistoryListPresenter()
        let router = WebHistoryListRouting()
        let interactor = WebHistoryListInteractor()
        let localDataManager = WebHistoryLocalDataManager()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.localDataManager = localDataManager
        return view
    }
    
    
}
