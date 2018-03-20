//
//  KaraokeFinderPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class KaraokeFinderPresenter {

    // MARK: Properties

    weak var view: KaraokeFinderView?
    var router: KaraokeFinderWireframe?
    var interactor: KaraokeFinderUseCase?
}

extension KaraokeFinderPresenter: KaraokeFinderPresentation {
    // TODO: implement presentation methods
}

extension KaraokeFinderPresenter: KaraokeFinderInteractorOutput {
    // TODO: implement interactor output methods
}
