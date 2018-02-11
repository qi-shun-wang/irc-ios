//
//  MediaShareMusicRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/4.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MediaShareMusicRouter {

    // MARK: Properties

    weak var view: UIViewController?
    weak var dlnaManager:DLNAMediaManagerProtocol?
    var player:AVPlayer?
    // MARK: Static methods

    static func setupModule(dlnaManager:DLNAMediaManagerProtocol,player:AVPlayer) -> MediaShareMusicViewController {
        let viewController = UIStoryboard.loadViewController() as MediaShareMusicViewController
        let presenter = MediaShareMusicPresenter()
        let router = MediaShareMusicRouter()
        let interactor = MediaShareMusicInteractor(dlnaManager:dlnaManager)

        viewController.presenter = presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController
        router.dlnaManager = dlnaManager
        router.player = player
        interactor.output = presenter

        return viewController
    }
}

extension MediaShareMusicRouter: MediaShareMusicWireframe {
    
    // TODO: Implement wireframe methods
    func navigateBack() {
        view?.navigationController?.dismissPopupBar(animated: true)
        view?.navigationController?.popViewController(animated: true)
    }
    
    func pushMusicList(_ album: Album) {
        let musicListView = MediaShareMusicListRouter.setupModule(dlnaManager:dlnaManager!,with: album,player:player!)
        view?.navigationController?.pushViewController(musicListView, animated: true)
    }
    
    func pushMusicList(_ playlist: Playlist) {
        let musicListView = MediaShareMusicListRouter.setupModule(dlnaManager:dlnaManager!,with: playlist,player:player!)
        view?.navigationController?.pushViewController(musicListView, animated: true)
    }
    
    func pushMusicPlayer(_ song: Song) {
        let player =  MediaShareMusicPlayerRouter.setupModule(dlnaManager: dlnaManager!, with: song)
        view?.navigationController?.pushViewController(player, animated: true)
    }
}
