//
//  WebPageRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/4/24.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class WebPageRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(url:String,with title:String) -> WebPageViewController {
        let viewController = UIStoryboard.loadViewController() as WebPageViewController
        let presenter = WebPagePresenter()
        let router = WebPageRouter()
        let interactor = WebPageInteractor()
        viewController.title = title
        viewController.presenter =  presenter
        
        presenter.url = url
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension WebPageRouter: WebPageWireframe {
    // TODO: Implement wireframe methods
}
