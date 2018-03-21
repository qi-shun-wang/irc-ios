//
//  KaraokeFinderRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/3/19.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class KaraokeFinderRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule(with service: KaraokeService, _ artist: Artist) -> KaraokeFinderViewController {
        let viewController = UIStoryboard.loadViewController() as KaraokeFinderViewController
        let presenter = KaraokeFinderPresenter()
        let router = KaraokeFinderRouter()
        let interactor = KaraokeFinderInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        presenter.artist = artist
        
        router.view = viewController

        interactor.output = presenter
        interactor.service = service
        return viewController
    }
}

extension KaraokeFinderRouter: KaraokeFinderWireframe {
    func navigateBack(){
        view?.navigationController?.popViewController(animated: true)
    }
}
