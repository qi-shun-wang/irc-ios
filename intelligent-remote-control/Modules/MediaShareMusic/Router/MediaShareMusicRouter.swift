//
//  MediaShareMusicRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareMusicRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MediaShareMusicViewController {
        let viewController = UIStoryboard.loadViewController() as MediaShareMusicViewController
        let presenter = MediaShareMusicPresenter()
        let router = MediaShareMusicRouter()
        let interactor = MediaShareMusicInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MediaShareMusicRouter: MediaShareMusicWireframe {
    // TODO: Implement wireframe methods
}
