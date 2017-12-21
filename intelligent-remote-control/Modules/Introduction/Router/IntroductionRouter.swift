//
//  IntroductionRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/21.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

protocol IntroductionRouterDelegate:class {
    func changeMain()
}
class IntroductionRouter {

    // MARK: Properties
    weak var delegate:IntroductionRouterDelegate?
    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(delegate:IntroductionRouterDelegate) -> IntroductionViewController {
        let viewController = UIStoryboard.loadViewController() as IntroductionViewController
        let presenter = IntroductionPresenter()
        let router = IntroductionRouter()
        let interactor = IntroductionInteractor()
        
        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.delegate = delegate
        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension IntroductionRouter: IntroductionWireframe {
    // TODO: Implement wireframe methods
    func changeMainController() {
        delegate?.changeMain()
    }
}
