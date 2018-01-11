//
//  MediaShareMusicListRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class MediaShareMusicListRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    private static func commonSetup(with interactor:MediaShareMusicListInteractor) -> MediaShareMusicListViewController  {
        let viewController = UIStoryboard.loadViewController() as MediaShareMusicListViewController
        let presenter = MediaShareMusicListPresenter()
        let router = MediaShareMusicListRouter()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        router.dlnaManager = interactor.dlnaManager
        interactor.output = presenter
        
        
        return viewController
    }
    
    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,with album:Album) -> MediaShareMusicListViewController {
        
        let interactor = MediaShareMusicListInteractor(dlnaManager: dlnaManager, with: album)
        return commonSetup(with: interactor)
        
    }
    
    
    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,with playlist:Playlist) -> MediaShareMusicListViewController {
        
        let interactor = MediaShareMusicListInteractor(dlnaManager: dlnaManager, with: playlist)
        return commonSetup(with: interactor)
    }
    
    weak var dlnaManager:DLNAMediaManagerProtocol?
}

extension MediaShareMusicListRouter: MediaShareMusicListWireframe {
    // TODO: Implement wireframe methods
    func navigateBack() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    func pushMusicPlayer(_ song: Song) {
        let player =  MediaShareMusicPlayerRouter.setupModule(dlnaManager: dlnaManager!, with: song)
        view?.navigationController?.pushViewController(player, animated: true)
    }
}
