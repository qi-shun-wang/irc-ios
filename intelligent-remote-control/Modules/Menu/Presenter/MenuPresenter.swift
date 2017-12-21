//
//  MenuPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MenuPresenter {

    // MARK: Properties

    weak var view: MenuView?
    var router: MenuWireframe?
    var interactor: MenuUseCase?
}

extension MenuPresenter: MenuPresentation {
    // TODO: implement presentation methods
}

extension MenuPresenter: MenuInteractorOutput {
    // TODO: implement interactor output methods
}
