//
//  MediaShareRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareRouter :NSObject{

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods
    
    static func setupModule(dlnaManager:DLNAMediaManagerProtocol) -> UINavigationController {
//        let nv = UIStoryboard.loadViewController() as MediaShareNavigationController
//        guard let viewController = nv.childViewControllers.first as? MediaShareViewController else {
//            return MediaShareNavigationController()
//        }
        let viewController = UIStoryboard.loadViewController() as MediaShareViewController
        let nv = UINavigationController(rootViewController: viewController)
        let presenter = MediaSharePresenter()
        let router = MediaShareRouter()
        let interactor = MediaShareInteractor()
        
        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController
        router.dlnaManager = dlnaManager
        interactor.output = presenter
    
        return nv
    }
     var dlnaManager:DLNAMediaManagerProtocol?
}

extension MediaShareRouter: MediaShareWireframe {
    
    // TODO: Implement wireframe methods
    func pushPhotos() {
        let photos = MediaSharePhotosRouter.setupModule(dlnaManager: dlnaManager!)
        view?.navigationController?.pushViewController(photos, animated: true)
    }
    
    func presentDMRList() {
        let dmrList = MediaShareDMRListRouter.setupModule(dlnaManager: dlnaManager!)
        dmrList.modalPresentationStyle = .custom
        dmrList.transitioningDelegate = self
        view?.present(dmrList, animated: true, completion: nil)
    
    }
    
}

extension MediaShareRouter: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DMRListDismissalTransition()
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DMRListPresentationTransition()
    }
}
