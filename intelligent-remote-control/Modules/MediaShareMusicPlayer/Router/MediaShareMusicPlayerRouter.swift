//
//  MediaShareMusicPlayerRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareMusicPlayerRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,with song: Song) -> MediaShareMusicPlayerViewController {
        let viewController = UIStoryboard.loadViewController() as MediaShareMusicPlayerViewController
        let presenter = MediaShareMusicPlayerPresenter()
        let router = MediaShareMusicPlayerRouter()
        let interactor = MediaShareMusicPlayerInteractor(dlnaManager: dlnaManager, song: song)

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MediaShareMusicPlayerRouter: MediaShareMusicPlayerWireframe {
    // TODO: Implement wireframe methods
    func navigateBack() {
        view?.navigationController?.popViewController(animated: true)
    }
}
