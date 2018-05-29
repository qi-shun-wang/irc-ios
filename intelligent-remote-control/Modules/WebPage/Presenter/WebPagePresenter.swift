//
//  WebPagePresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/24.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class WebPagePresenter {

    // MARK: Properties
    var url:String!
    weak var view: WebPageView?
    var router: WebPageWireframe?
    var interactor: WebPageUseCase?
}

extension WebPagePresenter: WebPagePresentation {
    
    func viewWillDisappear() {
        
    }
    
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
        view?.setupWeb(url: url)
    }
}

extension WebPagePresenter: WebPageInteractorOutput {
    // TODO: implement interactor output methods
}
