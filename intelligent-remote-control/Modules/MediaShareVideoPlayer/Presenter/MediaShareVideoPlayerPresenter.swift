//
//  MediaShareVideoPlayerPresenter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import AVFoundation
class MediaShareVideoPlayerPresenter {

    // MARK: Properties

    weak var view: MediaShareVideoPlayerView?
    var router: MediaShareVideoPlayerWireframe?
    var interactor: MediaShareVideoPlayerUseCase?

}

extension MediaShareVideoPlayerPresenter: MediaShareVideoPlayerPresentation {
    func viewDidLoad() {
        interactor?.fetchAsset()
    }
    
    func prepareCasting() {
        router?.presentDMRList()
    }
}

extension MediaShareVideoPlayerPresenter: MediaShareVideoPlayerInteractorOutput {
    // TODO: implement interactor output methods
    func didLoad(_ video:AVAsset){
        view?.setupThumbSelectorView(with: video)
    }
}
