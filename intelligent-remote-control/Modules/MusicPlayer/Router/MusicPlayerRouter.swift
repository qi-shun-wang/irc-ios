//
//  MusicPlayerRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/2/7.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MusicPlayerRouter :NSObject {

    // MARK: Properties

    weak var view: UIViewController?
    weak var dlnaManager:DLNAMediaManagerProtocol?
    // MARK: Static methods
    
    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,with playlist: [Song],player:AVPlayer,at index:Int) -> MusicPlayerViewController {
        let viewController = UIStoryboard.loadViewController() as MusicPlayerViewController
        let presenter = MusicPlayerPresenter()
        let router = MusicPlayerRouter()
        let interactor = MusicPlayerInteractor(dlnaManager: dlnaManager, with: playlist, at: index)
        interactor.setupPlayer(player)
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

extension MusicPlayerRouter: MusicPlayerWireframe {
    // TODO: Implement wireframe methods
    func presentDMRList() {
        let dmrList = MediaShareDMRListRouter.setupModule(dlnaManager: dlnaManager!)
        dmrList.delegate = self
        dmrList.modalPresentationStyle = .custom
        dmrList.transitioningDelegate = self
        view?.present(dmrList, animated: true, completion: nil)
    }
    
}

extension MusicPlayerRouter: MediaShareDMRListViewControllerDelegate{
    func didDismissMediaShareDMRListView() {
        (view as? MusicPlayerViewController)?.presenter?.prepareCurrentDevice()
    }
}

extension MusicPlayerRouter: UIViewControllerTransitioningDelegate {
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DMRListDismissalTransition()
    }
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DMRListPresentationTransition()
    }
}


