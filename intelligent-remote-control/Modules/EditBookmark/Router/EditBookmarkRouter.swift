//
//  EditBookmarkRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/26.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class EditBookmarkRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> EditBookmarkViewController {
        let viewController = UIStoryboard.loadViewController() as EditBookmarkViewController
        let presenter = EditBookmarkPresenter()
        let router = EditBookmarkRouter()
        let interactor = EditBookmarkInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension EditBookmarkRouter: EditBookmarkWireframe {
    // TODO: Implement wireframe methods
}
