//
//  DeviceDiscoveryRouter.swift
//  intelligent-remote-control
//
//  Created by QiShunWang on 2018/1/30.
//  Copyright © 2018年 ising99. All rights reserved.
//

import Foundation
import UIKit

class DeviceDiscoveryRouter {
    
    // MARK: Properties
    
    weak var view: UIViewController?
    
    // MARK: Static methods
    
    static func setupModule(with manager:DiscoveryServiceManagerProtocol) -> UINavigationController {
        let viewController = UIStoryboard.loadViewController() as DeviceDiscoveryViewController
        let nv = UINavigationController(rootViewController: viewController)
        nv.navigationBar.isHidden = true
        let presenter = DeviceDiscoveryPresenter()
        let router = DeviceDiscoveryRouter()
        let interactor = DeviceDiscoveryInteractor(manager: manager)
        
        viewController.presenter =  presenter
        
        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor
        
        router.view = viewController
        
        interactor.output = presenter
        
        return nv
    }
}

extension DeviceDiscoveryRouter: DeviceDiscoveryWireframe {
    // TODO: Implement wireframe methods
    func dismissDeviceDiscovery(){
        view?.navigationController?.dismiss(animated: true)
    }
}
