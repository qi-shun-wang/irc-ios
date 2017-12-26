//
//  WebBookmarkRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/20.
//  Copyright © 2017年 ising99. All rights reserved.
//

import Foundation
import UIKit

class WebBookmarkRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> WebBookmarkNavigationController {
        
        let nv = UIStoryboard.loadViewController() as WebBookmarkNavigationController
        
        guard let viewController = nv.childViewControllers.first as? WebBookmarkViewController else {
            return WebBookmarkNavigationController()
        }
        let presenter = WebBookmarkPresenter()
        let router = WebBookmarkRouter()
        let interactor = WebBookmarkInteractor()

        viewController.presenter =  presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return nv
    }
    deinit {
        print("deinit---->\(self)")
    }
}

extension WebBookmarkRouter: WebBookmarkWireframe {
    
    // TODO: Implement wireframe methods
    func dismiss() {
        view?.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func pushEditFolder(category: Bookmark) {
        let editFolder = EditFolderRouter.setupModule()
        view?.navigationController?.pushViewController(editFolder, animated: true)
    }
    
    func pushEditFolder() {
        let editFolder = EditFolderRouter.setupModule()
        view?.navigationController?.pushViewController(editFolder, animated: true)
    }
}
