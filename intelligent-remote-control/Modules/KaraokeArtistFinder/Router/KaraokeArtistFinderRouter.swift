//
//  KaraokeArtistFinderRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class KaraokeArtistFinderRouter {

    // MARK: Properties

    weak var view: UIViewController?
    var service:KaraokeService?
    // MARK: Static methods

    static func setupModule(with service:KaraokeService) -> KaraokeArtistFinderViewController {
        let viewController = UIStoryboard.loadViewController() as KaraokeArtistFinderViewController
        let presenter = KaraokeArtistFinderPresenter()
        let router = KaraokeArtistFinderRouter()
        let interactor = KaraokeArtistFinderInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController
        router.service = service
        
        interactor.output = presenter
        interactor.service = service

        return viewController
    }
}

extension KaraokeArtistFinderRouter: KaraokeArtistFinderWireframe {
    
    func navigateBack() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func pushToKaraokeFinder(with artist: Artist) {
        let karaokeFinder = KaraokeFinderRouter.setupModule(with: service!, artist)
        view?.navigationController?.pushViewController(karaokeFinder, animated: true)
    }
    
}
