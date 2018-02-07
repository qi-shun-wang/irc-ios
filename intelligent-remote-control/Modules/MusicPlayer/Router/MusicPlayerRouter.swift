//
//  MusicPlayerRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MusicPlayerRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,with song: Song) -> MusicPlayerViewController {
        let viewController = UIStoryboard.loadViewController() as MusicPlayerViewController
        let presenter = MusicPlayerPresenter()
        let router = MusicPlayerRouter()
        let interactor = MusicPlayerInteractor(dlnaManager: dlnaManager, song: song)

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MusicPlayerRouter: MusicPlayerWireframe {
    // TODO: Implement wireframe methods
}
