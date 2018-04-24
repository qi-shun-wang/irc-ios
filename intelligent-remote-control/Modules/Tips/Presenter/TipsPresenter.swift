//
//  TipsPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/24.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class TipsPresenter {

    // MARK: Properties

    weak var view: TipsView?
    var router: TipsWireframe?
    var interactor: TipsUseCase?
}

extension TipsPresenter: TipsPresentation {
    // TODO: implement presentation methods
}

extension TipsPresenter: TipsInteractorOutput {
    // TODO: implement interactor output methods
}
