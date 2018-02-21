//
//  MediaShareVideoPlayerContract.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import AVFoundation

protocol MediaShareVideoPlayerView: BaseView {
    func setupThumbSelectorView(with asset:AVAsset)
}

protocol MediaShareVideoPlayerPresentation: class {
    func viewDidLoad()
    func prepareCasting()
}

protocol MediaShareVideoPlayerUseCase: class {
    // TODO: Declare use case methods
    func fetchAsset()
}

protocol MediaShareVideoPlayerInteractorOutput: class {
    func didLoad(_ video:AVAsset)
}

protocol MediaShareVideoPlayerWireframe: class {
    func presentDMRList()
}
