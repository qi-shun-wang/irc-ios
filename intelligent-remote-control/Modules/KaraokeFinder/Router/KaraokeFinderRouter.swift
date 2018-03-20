//
//  KaraokeFinderRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class KaraokeFinderRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> KaraokeFinderViewController {
        let viewController = UIStoryboard.loadViewController() as KaraokeFinderViewController
        let presenter = KaraokeFinderPresenter()
        let router = KaraokeFinderRouter()
        let interactor = KaraokeFinderInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension KaraokeFinderRouter: KaraokeFinderWireframe {
    // TODO: Implement wireframe methods
}
