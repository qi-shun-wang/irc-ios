//
//  File.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2017/12/18.
//  Copyright © 2017年 ising99. All rights reserved.
//

import UIKit

class WebBookmarksRouting:WebBookmarksRoutingProtocol {
    
    private init(_ navigationView:UIViewController) {
        self.navigationView = navigationView
    }
    static func createWebBookmarksModule() -> UIViewController {
        let story = UIStoryboard(name: "WebBookmarks", bundle: Bundle.main)
        let navigationController = story.instantiateViewController(withIdentifier: "WebBookmarksNavigationController")
        guard let view = navigationController.childViewControllers.first as? WebBookmarksViewController else {
            print("WebBookmarksRouting Eror:RootViewController of NavigationController doesn't setup")
            return UIViewController()
        }
        //view.setup vipr here....
        let presenter = WebBookmarksPresenter()
        
        let router = WebBookmarksRouting(navigationController)
        
        view.presenter = presenter
        presenter.view = view
        //        presenter.interactor = interactor
        presenter.router = router
        //        interactor.presenter = presenter
        //        interactor.localDataManager = localDataManager
        
        
        return navigationController
    }
    
    
    weak var navigationView: UIViewController?
    
    func dismiss() {
        navigationView?.dismiss(animated: true, completion: nil)
    }
}
