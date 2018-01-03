//
//  MediaSharePhotosRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaSharePhotosRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MediaSharePhotosViewController {
        let viewController = UIStoryboard.loadViewController() as MediaSharePhotosViewController
        let presenter = MediaSharePhotosPresenter()
        let router = MediaSharePhotosRouter()
        let interactor = MediaSharePhotosInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MediaSharePhotosRouter: MediaSharePhotosWireframe {
    // TODO: Implement wireframe methods
}
