//
//  WebBrowserRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class WebBrowserRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> WebBrowserNavigationController {
        let nv = UIStoryboard.loadViewController() as WebBrowserNavigationController
        guard let viewController = nv.childViewControllers.first as? WebBrowserViewController else {
            return WebBrowserNavigationController()
        }
        let presenter = WebBrowserPresenter()
        let router = WebBrowserRouter()
        let interactor = WebBrowserInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return nv
    }
}

extension WebBrowserRouter: WebBrowserWireframe {
    // TODO: Implement wireframe methods
}
