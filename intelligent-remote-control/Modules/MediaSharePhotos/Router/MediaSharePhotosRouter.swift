//
//  MediaSharePhotosRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaSharePhotosRouter :NSObject{

    // MARK: Properties

    weak var view: UIViewController?
    weak var dlnaManager:DLNAMediaManagerProtocol?
    // MARK: Static methods

    static func setupModule(dlnaManager:DLNAMediaManagerProtocol) -> MediaSharePhotosViewController {
        let viewController = UIStoryboard.loadViewController() as MediaSharePhotosViewController
        let presenter = MediaSharePhotosPresenter()
        let router = MediaSharePhotosRouter()
        let interactor = MediaSharePhotosInteractor()

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

extension MediaSharePhotosRouter: MediaSharePhotosWireframe {
    
    // TODO: Implement wireframe methods
    func presentDMRList() {
        let dmrList = MediaShareDMRListRouter.setupModule(dlnaManager: dlnaManager!)
        dmrList.delegate = self
        dmrList.modalPresentationStyle = .custom
        dmrList.transitioningDelegate = self
        view?.present(dmrList, animated: true, completion: nil)
    }
    
}

extension MediaSharePhotosRouter: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DMRListDismissalTransition()
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DMRListPresentationTransition()
    }
}

extension MediaSharePhotosRouter: MediaShareDMRListViewControllerDelegate{
    func didDismissMediaShareDMRListView() {
//        (view as? MediaSharePhotosViewController)?.presenter?.fetchCurrentDevice()
    }
}
