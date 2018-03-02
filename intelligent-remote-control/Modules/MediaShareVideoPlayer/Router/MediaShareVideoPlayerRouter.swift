//
//  MediaShareVideoPlayerRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/14.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareVideoPlayerRouter: NSObject {

    // MARK: Properties

    weak var view: UIViewController?
    weak var dlnaManager:DLNAMediaManagerProtocol?
    // MARK: Static methods

    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,with video:VideoAsset) -> MediaShareVideoPlayerViewController {
        let viewController = UIStoryboard.loadViewController() as MediaShareVideoPlayerViewController
        let presenter = MediaShareVideoPlayerPresenter()
        let router = MediaShareVideoPlayerRouter()
        let interactor = MediaShareVideoPlayerInteractor(dlnaManager: dlnaManager,with: video)

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController
        router.dlnaManager = dlnaManager
        interactor.output = presenter

        return viewController
    }
}

extension MediaShareVideoPlayerRouter: MediaShareVideoPlayerWireframe {
    
    func presentDMRList() {
        let dmrList = MediaShareDMRListRouter.setupModule(dlnaManager: dlnaManager!)
        dmrList.delegate = self
        dmrList.modalPresentationStyle = .custom
        dmrList.transitioningDelegate = self
        view?.present(dmrList, animated: true, completion: nil)
    }

}
extension MediaShareVideoPlayerRouter: MediaShareDMRListViewControllerDelegate {
    func didDismissMediaShareDMRListView() {
        (view as? MediaShareVideoPlayerViewController)?.presenter?.prepareCurrentDevice()
    }
}

extension MediaShareVideoPlayerRouter: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DMRListDismissalTransition()
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DMRListPresentationTransition()
    }
}
