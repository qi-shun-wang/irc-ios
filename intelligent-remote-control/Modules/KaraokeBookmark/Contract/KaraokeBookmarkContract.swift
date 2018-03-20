//
//  KaraokeBookmarkContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

protocol KaraokeBookmarkView: BaseView {
    // TODO: Declare view methods
}

protocol KaraokeBookmarkPresentation: BasePresentation {
    func navigateBack()
}

protocol KaraokeBookmarkUseCase: class {
    // TODO: Declare use case methods
}

protocol KaraokeBookmarkInteractorOutput: class {
    // TODO: Declare interactor output methods
}

protocol KaraokeBookmarkWireframe: class {
    func navigateBack()
}
