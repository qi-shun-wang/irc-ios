//
//  IRCRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class IRCRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods
    weak var manager:DiscoveryServiceManagerProtocol?
    static func setupModule(with manager:DiscoveryServiceManagerProtocol) -> IRCNavigationController {
        
        let nv = UIStoryboard.loadViewController() as IRCNavigationController
        guard let viewController = nv.childViewControllers.first as? IRCViewController else {
            return IRCNavigationController()
        }
        
        let presenter = IRCPresenter()
        let router = IRCRouter()
        let interactor = IRCInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController
        router.manager = manager
        interactor.output = presenter
        interactor.manager = manager
        return nv
    }
}

extension IRCRouter: IRCWireframe {
    // TODO: Implement wireframe methods
    func presentDeviceDiscovery() {
        let deviceDiscovery = DeviceDiscoveryRouter.setupModule(with: manager!)
        view?.navigationController?.present(deviceDiscovery, animated: true)
    }
}
