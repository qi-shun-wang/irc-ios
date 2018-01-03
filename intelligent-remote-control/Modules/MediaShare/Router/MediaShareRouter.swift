//
//  MediaShareRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> MediaShareNavigationController {
        let nv = UIStoryboard.loadViewController() as MediaShareNavigationController
        guard let viewController = nv.childViewControllers.first as? MediaShareViewController else {
            return MediaShareNavigationController()
        }
        let presenter = MediaSharePresenter()
        let router = MediaShareRouter()
        let interactor = MediaShareInteractor()
        
        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return nv
    }
}

extension MediaShareRouter: MediaShareWireframe {
    
    // TODO: Implement wireframe methods
    func pushPhotos() {
        let photos = MediaSharePhotosRouter.setupModule()
        view?.navigationController?.pushViewController(photos, animated: true)
    }
    
}
