//
//  MediaShareRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/3.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MediaShareRouter :NSObject{

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods
    
    static func setupModule(dlnaManager:DLNAMediaManagerProtocol) -> UINavigationController {

        let viewController = UIStoryboard.loadViewController() as MediaShareViewController
        let nv = UINavigationController(rootViewController: viewController)
        nv.navigationBar.isTranslucent = false
        let presenter = MediaSharePresenter()
        let router = MediaShareRouter()
        let interactor = MediaShareInteractor(dlnaManager: dlnaManager)
        
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
    func dismissMediaShare(){
        view?.navigationController?.dismiss(animated: true)
    }
    
    func pushMusic() {
        let player = AVPlayer()
        let music = MediaShareMusicRouter.setupModule(dlnaManager: dlnaManager!,player:player)
        view?.navigationController?.pushViewController(music, animated: true)
    }
    
    func pushPhotos() {
        let photos = MediaSharePhotosRouter.setupModule(dlnaManager: dlnaManager!)
        view?.navigationController?.pushViewController(photos, animated: true)
    }
    
    func pushVideos() {
        let videos = MediaShareVideosRouter.setupModule(dlnaManager: dlnaManager!)
        view?.navigationController?.pushViewController(videos, animated: true)
    }
    
    
    
}

