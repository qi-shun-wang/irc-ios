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
    var service:KaraokeService?
    // MARK: Static methods

    static func setupModule(with service:KaraokeService) -> KaraokeNavigationController {
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
        router.service = service
        
        interactor.output = presenter

        return nv
    }
}

extension KaraokeRouter: KaraokeWireframe {
    
    func pushToFinder() {
        let finderView = KaraokeArtistFinderRouter.setupModule(with: service!)
        view?.navigationController?.pushViewController(finderView, animated: true)
    }
    
    func pushToBookmark() {
        let bookmarkView = KaraokeBookmarkRouter.setupModule(with: service!)
        view?.navigationController?.pushViewController(bookmarkView, animated: true)
    }
}
