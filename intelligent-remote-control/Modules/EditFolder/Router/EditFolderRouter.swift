//
//  EditFolderRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/25.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class EditFolderRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> EditFolderViewController {
        let viewController = UIStoryboard.loadViewController() as EditFolderViewController
        let presenter = EditFolderPresenter()
        let router = EditFolderRouter()
        let interactor = EditFolderInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension EditFolderRouter: EditFolderWireframe {
    // TODO: Implement wireframe methods
}
