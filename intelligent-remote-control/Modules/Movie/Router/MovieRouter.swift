//
//  MovieRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MovieRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MovieNavigationController {
        let nv = UIStoryboard.loadViewController() as MovieNavigationController
        guard let viewController = nv.childViewControllers.first as? MovieViewController else {
            return MovieNavigationController()
        }
        
        let presenter = MoviePresenter()
        let router = MovieRouter()
        let interactor = MovieInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return nv
    }
}

extension MovieRouter: MovieWireframe {
    // TODO: Implement wireframe methods
}
