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
    
}

extension IRCPresenter: IRCPresentation {
    
    // TODO: implement presentation methods
    func viewDidLoad() {
    }
    
}

extension IRCPresenter: IRCInteractorOutput {
    // TODO: implement interactor output methods
}
