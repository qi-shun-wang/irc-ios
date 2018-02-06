//
//  MediaShareVideosRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/6.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareVideosRouter {

    // MARK: Properties

    weak var view: UIViewController?
    weak var dlnaManager:DLNAMediaManagerProtocol?
    // MARK: Static methods

    static func setupModule(dlnaManager:DLNAMediaManagerProtocol) -> MediaShareVideosViewController {
        let viewController = UIStoryboard.loadViewController() as MediaShareVideosViewController
        let presenter = MediaShareVideosPresenter()
        let router = MediaShareVideosRouter()
        let interactor = MediaShareVideosInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController
        router.dlnaManager = dlnaManager
        interactor.dlnaManager = dlnaManager
        interactor.output = presenter

        return viewController
    }
}

extension MediaShareVideosRouter: MediaShareVideosWireframe {
    func presentDMRList() {
        let dmrList = MediaShareDMRListRouter.setupModule(dlnaManager: dlnaManager!)
        view?.present(dmrList, animated: true, completion: nil)
    }
}
