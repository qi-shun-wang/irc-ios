//
//  MenuRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MenuRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(serviceMananger:DiscoveryServiceManagerProtocol) -> MenuViewController {
        let viewController = UIStoryboard.loadViewController() as MenuViewController
        let presenter = MenuPresenter()
        let router = MenuRouter()
        let interactor = MenuInteractor(serviceMananger:serviceMananger)

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MenuRouter: MenuWireframe {
    // TODO: Implement wireframe methods
}
