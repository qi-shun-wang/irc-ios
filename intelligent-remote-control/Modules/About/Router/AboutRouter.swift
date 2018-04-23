//
//  AboutRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/23.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class AboutRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> UINavigationController {
        let viewController = UIStoryboard.loadViewController() as AboutViewController
        let nv = UINavigationController(rootViewController: viewController)
        let presenter = AboutPresenter()
        let router = AboutRouter()
        let interactor = AboutInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return nv
    }
}

extension AboutRouter: AboutWireframe {
    // TODO: Implement wireframe methods
    func dismissAbout(){
        view?.navigationController?.dismiss(animated: true)
    }
}
