//
//  MediaShareMusicListRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/11.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MediaShareMusicListRouter :NSObject {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    private static func commonSetup(with interactor:MediaShareMusicListInteractor,player:AVPlayer) -> MediaShareMusicListViewController  {
        let viewController = UIStoryboard.loadViewController() as MediaShareMusicListViewController
        let presenter = MediaShareMusicListPresenter()
        let router = MediaShareMusicListRouter()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        router.dlnaManager = interactor.dlnaManager
        router.player = player
        interactor.output = presenter
        
        
        return viewController
    }
    
    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,with album:Album,player:AVPlayer) -> MediaShareMusicListViewController {
        
        let interactor = MediaShareMusicListInteractor(dlnaManager: dlnaManager, with: album)
        return commonSetup(with: interactor,player:player)
        
    }
    
    
    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,with playlist:Playlist,player:AVPlayer) -> MediaShareMusicListViewController {
        
        let interactor = MediaShareMusicListInteractor(dlnaManager: dlnaManager, with: playlist)
        return commonSetup(with: interactor,player:player)
    }
    
    weak var dlnaManager:DLNAMediaManagerProtocol?
    var player:AVPlayer?
    weak var popupContentController:MusicPlayerViewController?
}

extension MediaShareMusicListRouter: MediaShareMusicListWireframe {
    // TODO: Implement wireframe methods
    func navigateBack() {
        popupContentController?.presenter?.stopProgress()
        view?.navigationController?.popViewController(animated: true)
    }
    
    func pushMusicPlayer(with playlist: [Song], at index: Int) {
        
        popupContentController?.presenter?.stopProgress()
        popupContentController = MusicPlayerRouter.setupModule(dlnaManager: dlnaManager!, with: playlist, player: player!, at: index)
        
        view?.navigationController?.popupBar.tintColor = UIColor(white: 38.0 / 255.0, alpha: 1.0)
        view?.navigationController?.popupBar.imageView.layer.cornerRadius = 5
        
        view?.navigationController?.presentPopupBar(withContentViewController: popupContentController!, animated: true, completion: nil)
    }
    
    
}
