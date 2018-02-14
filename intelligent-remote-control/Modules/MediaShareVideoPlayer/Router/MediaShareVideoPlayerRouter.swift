//
//  MediaShareVideoPlayerRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareVideoPlayerRouter {

    // MARK: Properties

    weak var view: UIViewController?
    weak var dlnaManager:DLNAMediaManagerProtocol?
    // MARK: Static methods

    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,with video:VideoAsset) -> MediaShareVideoPlayerViewController {
        let viewController = UIStoryboard.loadViewController() as MediaShareVideoPlayerViewController
        let presenter = MediaShareVideoPlayerPresenter()
        let router = MediaShareVideoPlayerRouter()
        let interactor = MediaShareVideoPlayerInteractor(dlnaManager: dlnaManager,with: video)

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MediaShareVideoPlayerRouter: MediaShareVideoPlayerWireframe {
    // TODO: Implement wireframe methods
}
