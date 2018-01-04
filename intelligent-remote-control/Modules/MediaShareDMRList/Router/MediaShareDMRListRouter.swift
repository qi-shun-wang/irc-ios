//
//  MediaShareDMRListRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareDMRListRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(dlnaManager:DLNAMediaManagerProtocol) -> MediaShareDMRListViewController {
        let viewController = UIStoryboard.loadViewController() as MediaShareDMRListViewController
        let presenter = MediaShareDMRListPresenter()
        let router = MediaShareDMRListRouter()
        let interactor = MediaShareDMRListInteractor(dlnaManager: dlnaManager)

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension MediaShareDMRListRouter: MediaShareDMRListWireframe {
   
    // TODO: Implement wireframe methods
    func dismissMediaShareDMRListView() {
        view?.dismiss(animated: true, completion: nil)
    }
}
