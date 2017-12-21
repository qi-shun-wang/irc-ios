//
//  IRCPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class IRCPresenter {

    // MARK: Properties

    weak var view: IRCView?
    var router: IRCWireframe?
    var interactor: IRCUseCase?
    
    func setupNavigationLeftItem(image named: String, title text: String) {
        view?.setupNavigationLeftItem(image: "radio_icon", title: " 已連結到 KOD iSing99-00")
        
    }
    
    func setupNavigationRightItem(image named: String, title text: String) {
        view?.setupNavigationRightItem(image: "qr_code_scan_icon", title: "")
    }
    
}

extension IRCPresenter: IRCPresentation {
    
    // TODO: implement presentation methods
    func viewDidLoad() {
        
        view?.setupNavigationBarStyle()
    }
    
}

extension IRCPresenter: IRCInteractorOutput {
    // TODO: implement interactor output methods
}
