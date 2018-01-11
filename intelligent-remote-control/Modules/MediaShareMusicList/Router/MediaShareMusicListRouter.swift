//
//  MediaShareMusicListRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareMusicListRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,with album:Album) -> MediaShareMusicListViewController {
        let viewController = UIStoryboard.loadViewController() as MediaShareMusicListViewController
        let presenter = MediaShareMusicListPresenter()
        let router = MediaShareMusicListRouter()
        let interactor = MediaShareMusicListInteractor(dlnaManager: dlnaManager, with: album)

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MediaShareMusicListRouter: MediaShareMusicListWireframe {
    // TODO: Implement wireframe methods
    func navigateBack() {
        view?.navigationController?.popViewController(animated: true)
    }
}
