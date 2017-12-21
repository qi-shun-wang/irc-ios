//
//  BaseTabBarPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class BaseTabBarPresenter {

    // MARK: Properties

    weak var view: BaseTabBarView?
    var router: BaseTabBarWireframe?
    var interactor: BaseTabBarUseCase?
}

extension BaseTabBarPresenter: BaseTabBarPresentation {
    // TODO: implement presentation methods
    func presentTabs() {
        router?.presentTabs()
    }
}

extension BaseTabBarPresenter: BaseTabBarInteractorOutput {
    // TODO: implement interactor output methods
}
