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
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.setupNavigationLeftItem(image: "radio_icon", title: " 已連結到 KOD iSing99-00")
        view?.setupNavigationRightItem(image: "qr_code_scan_icon", title: "")
        view?.setupNavigationBarStyle()
    }
    
    
}

extension WebBrowserPresenter: WebBrowserInteractorOutput {
    // TODO: implement interactor output methods
}
