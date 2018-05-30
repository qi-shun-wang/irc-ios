//
//  WebBrowserPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class WebBrowserPresenter {

    // MARK: Properties

    weak var view: WebBrowserView?
    var router: WebBrowserWireframe?
    var interactor: WebBrowserUseCase?
}

extension WebBrowserPresenter: WebBrowserPresentation {
    
    func viewWillAppear() {
        
    }
    
    func viewWillDisappear() {
        
    }
    
    func viewDidLoad() {
    }
    
    func presentBookmark(){
        router?.presentWebBookmark()
    }
}

extension WebBrowserPresenter: WebBrowserInteractorOutput {
    // TODO: implement interactor output methods
}
