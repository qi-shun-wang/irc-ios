//
//  MorePresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class MorePresenter {

    // MARK: Properties

    weak var view: MoreView?
    var router: MoreWireframe?
    var interactor: MoreUseCase?
}

extension MorePresenter: MorePresentation {
    // TODO: implement presentation methods
    func viewDidLoad() {
        view?.setupNavigationBarStyle()
    }
}

extension MorePresenter: MoreInteractorOutput {
    // TODO: implement interactor output methods
}
