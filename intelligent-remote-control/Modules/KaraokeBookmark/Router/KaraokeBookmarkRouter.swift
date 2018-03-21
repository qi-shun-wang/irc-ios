//
//  KaraokeBookmarkRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class KaraokeBookmarkRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(with service:KaraokeService) -> KaraokeBookmarkViewController {
        let viewController = UIStoryboard.loadViewController() as KaraokeBookmarkViewController
        let presenter = KaraokeBookmarkPresenter()
        let router = KaraokeBookmarkRouter()
        let interactor = KaraokeBookmarkInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter
        interactor.service = service
        return viewController
    }
}

extension KaraokeBookmarkRouter: KaraokeBookmarkWireframe {
    
    func navigateBack() {
        view?.navigationController?.popViewController(animated: true)
    }
}
