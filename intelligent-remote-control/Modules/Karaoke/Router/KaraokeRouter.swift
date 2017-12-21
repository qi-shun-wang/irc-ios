//
//  KaraokeRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class KaraokeRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> KaraokeNavigationController {
        let nv = UIStoryboard.loadViewController() as KaraokeNavigationController
        guard let viewController = nv.childViewControllers.first as? KaraokeViewController else {
            return KaraokeNavigationController()
        }
        
        let presenter = KaraokePresenter()
        let router = KaraokeRouter()
        let interactor = KaraokeInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return nv
    }
}

extension KaraokeRouter: KaraokeWireframe {
    // TODO: Implement wireframe methods
}
