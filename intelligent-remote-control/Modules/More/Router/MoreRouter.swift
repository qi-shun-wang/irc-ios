//
//  MoreRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MoreRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MoreNavigationController {
        
        let nv = UIStoryboard.loadViewController() as MoreNavigationController
        guard let viewController = nv.childViewControllers.first as? MoreViewController else {
            return MoreNavigationController()
        }
        let presenter = MorePresenter()
        let router = MoreRouter()
        let interactor = MoreInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        
        router.view = viewController
        let dlnaManager = DLNAMediaManager()
        router.dlnaManager = dlnaManager
        
        interactor.output = presenter

        return nv
    }
    var dlnaManager:DLNAMediaManagerProtocol?
}

extension MoreRouter: MoreWireframe {
    // TODO: Implement wireframe methods
    func presentMediaShare() {
        let mediaShare = MediaShareRouter.setupModule(dlnaManager: dlnaManager!)
        view?.present(mediaShare, animated: true, completion: nil)
    }
    
    func presentAbout() {
        let about = AboutRouter.setupModule()
        view?.present(about, animated: true, completion: nil)
    }
}
