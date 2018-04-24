//
//  TipsRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/24.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class TipsRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> TipsViewController {
        let viewController = UIStoryboard.loadViewController() as TipsViewController
        let presenter = TipsPresenter()
        let router = TipsRouter()
        let interactor = TipsInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension TipsRouter: TipsWireframe {
    // TODO: Implement wireframe methods
}
