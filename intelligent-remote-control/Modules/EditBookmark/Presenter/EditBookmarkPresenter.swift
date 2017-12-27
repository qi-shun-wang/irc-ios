//
//  EditBookmarkPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/26.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation

class EditBookmarkPresenter {

    // MARK: Properties

    weak var view: EditBookmarkView?
    var router: EditBookmarkWireframe?
    var interactor: EditBookmarkUseCase?
}

extension EditBookmarkPresenter: EditBookmarkPresentation {
    // TODO: implement presentation methods
}

extension EditBookmarkPresenter: EditBookmarkInteractorOutput {
    // TODO: implement interactor output methods
}
