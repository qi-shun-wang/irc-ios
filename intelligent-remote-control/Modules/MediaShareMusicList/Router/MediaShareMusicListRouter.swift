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
    typealias Manager = DLNAMediaManagerProtocol
    typealias View = MediaShareMusicListViewController
    typealias Interactor = MediaShareMusicListInteractor
    typealias Presenter = MediaShareMusicListPresenter
    typealias Router = MediaShareMusicListRouter
    // MARK: Properties
    
    weak var view: UIViewController?
    weak var dlnaManager:DLNAMediaManagerProtocol?
    var player:AVPlayer?
    weak var popupContentController:MusicPlayerViewController?

    // MARK: Static methods
    private static func commonSetup(with dlnaManager:Manager,_ interactor:Interactor,player:AVPlayer) -> View  {
        let viewController = UIStoryboard.loadViewController() as View
        let presenter = Presenter()
        let router = Router()
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        router.dlnaManager = dlnaManager
        router.player = player
        interactor.output = presenter
        
        
        return viewController
    }
    
    static func setupModule(dlnaManager:Manager,with album:Album,player:AVPlayer) -> View {
        
        let interactor = Interactor(with: album, dlnaManager)
        return commonSetup(with: dlnaManager,interactor, player: player)
        
    }
    
    static func setupModule(dlnaManager:Manager,with playlist:Playlist,player:AVPlayer) -> View {
        
        let interactor = Interactor(with: playlist, dlnaManager)
        return commonSetup(with: dlnaManager,interactor, player: player)
    }
    
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
