//
//  RootPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class RootPresenter {

    // MARK: Properties

    weak var view: RootView?
    var router: RootWireframe?
    var interactor: RootUseCase?
}

extension RootPresenter: RootPresentation {
    // TODO: implement presentation methods
    func awakeFromNib() {
        view?.setupRootStyle()
    }
}

extension RootPresenter: RootInteractorOutput {
    // TODO: implement interactor output methods
}
