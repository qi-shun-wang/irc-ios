//
//  MediaShareMusicPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation

class MediaShareMusicPresenter {

    // MARK: Properties

    weak var view: MediaShareMusicView?
    var router: MediaShareMusicWireframe?
    var interactor: MediaShareMusicUseCase?
}

extension MediaShareMusicPresenter: MediaShareMusicPresentation {
    // TODO: implement presentation methods
}

extension MediaShareMusicPresenter: MediaShareMusicInteractorOutput {
    // TODO: implement interactor output methods
}
